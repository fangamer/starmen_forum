class Message < ApplicationRecord
  include BackwardsCompat

  belongs_to :creator, class_name: "User", foreign_key: "user_id", inverse_of: :messages
  belongs_to :topic, inverse_of: :messages
  has_one :forum, through: :topic
  def infraction; nil; end #stub has_one :infraction, :dependent=>:destroy
  has_and_belongs_to_many :searchwords, :uniq =>true
  belongs_to :poll, optional: true
  def forumAttachments; nil; end #stub has_many :forumAttachments
  has_many :thumbs,:class_name=>"Thumbs", :dependent=>:destroy
  has_many :submissions
  belongs_to :emblem, optional: true
  has_many :reports, :dependent=>:destroy
  has_one :report,->{where(resolved_at:nil)}

  attr_accessor :override_bump # memory only attribute

  validates :creator, presence: true
  validates :body_original, presence: true, length: { in: 3..65535 }, format: { with: /[a-z]/i, message: "must contain at least one letter." }
  validate :not_banned_from_posting
  validate :not_banned_from_forum
  validate :not_banned_from_topic
  validate :topic_not_locked
  validate :invalid_emblem
  validate :flood_control, on: :create
  validate :alert_control, on: :create
  validate :spam_test
  validate :allowed_to_edit, on: :update
  validate :allowed_to_split, on: :update
  validate :allowed_to_create, on: :create
  #validates_associated :poll
  #validates_associated :attachments #<-- here where we check if can post attachment or not

  before_save :remove_html_from_original

  after_create :add_to_latest_message_on_topic
  after_create :update_forum_post_count
  after_create :email_subscriptions
  after_save :invalidate_caches

  # need both, if destroy is happening or just deleted is marks
  after_update  :fix_forum_and_topic_after_delete
  after_destroy :fix_forum_and_topic_after_destroy

  # okay this is huge and we need to unpack this
  scope :with_forum_ids, ->(forum_ids){
    # first get a search for the forum by topic
    topic = Topic.where(forum_id:forum_ids)

    # then also add a query for messages.topic_id = topics.id
    topic = topic.where(Topic.arel_table[:id].eq(Message.arel_table[:topic_id]))

    # finally wrap all that in an EXISTS(select..), this functions like a JOIN but without all the nastiness of doing a join,
    # such as additional columns or like having to have specific table names
    # so we can look for where(created_at:Time.now) on message and not have it whine and complain about created_at exists on topics and forums
    # since our exists subquery is scoped
    topic = topic.arel.exists

    # add the EXISTS() query as a where phrase to the main query
    where(topic)
  }
  # the alternative to the above is we just add a forum_id column to message, but that avoids the #1 thing about the rails 6 port: no unnecessary schema changes

  def url
    if self.topic.is_a?(Topic) && self.topic.forum.is_a?(Forum)
      "#{self.topic.URL}/#{self.id}"
    else
      "/forum/message/#{self.id}"
    end
  end
  alias_method :URL, :url

  def preview(size=50)
    ret = body_without_quotes_spoilers.gsub(/<\/?[^>]*>/, "").gsub(/\n/,"").gsub(/\r/,"").slice(0,size)
    if ret.blank?
      "Message cannot be shown due to it only containing quotes or spoilers."
    else
      ret
    end
  end

  def body_without_quotes_spoilers
    # for anybody who complains that html is being used for a regular expression, note that at least as of the time of this code was written the html was generated from the textile editor so was standardized
    ret = self.body.gsub(/\<blockquote(.*?)\<\/blockquote\>/mi,"").gsub(/\<div class=\"spoiler_container\"\>(.*?)\<\/div\>\s*\<\/div\>\s*\<\/div\>/mi,"").gsub(/\<span class=\"inline_spoiler\" style=\"color:#333;background-color:#333\"\>(\<span class=\"inline_spoiler_title\" style=\"color:#F00\"\>(.*?)\<\/span\>)?(.*?)\<\/span\>/mi,"")
    ret.gsub(/&#8217;/,"'")
  end

  def body
    # return memory cache
    return @_body if @_body

    # # if it's in the data return the cached html
    # return read_attributes(:body) unless read_attributes(:body).blank?
    # # but for now, we will live process all html because who knows what stinky html is in the cache
    process_body
  end

  def process_body
    allowimages = forum.try(:can_post_images?) || false

    #TODO: disable_styling punishment? starmen doesn't use it so might have been a client request
    processed_body = RedCloth.new(body_original,[:no_span_caps,:filter_html,(self.disable_textile ? :bbcode_only : :bbcode),{:disable_inline=>disablers(allowimages)}]).to_html

    #TODO: Smilies
    #TODO: SwearWords
    #TODO: Sanitize post from naughty Javascript (security) and CSS (ugly)
    #TODO: older posts are allowed to use the stored value because they probably won't reprocess well.

    @_body = processed_body.html_safe
  end

  def remove_html_from_original
    self.body_original.gsub!(/</,"&lt;")
    self.body_original.gsub!(/>/,"&gt;")
  end

  def not_banned_from_posting
    #TODO
    if false
      errors.add :base, "You are banned from posting."
    end
  end

  def not_banned_from_forum
    #TODO
    if false
      errors.add :base, "You are banned from this forum."
    end
  end

  def not_banned_from_topic
    #TODO
    if false
      errors.add :base, "You are banned from this topic."
    end
  end

  def topic_not_locked
    if false
      errors.add :base, "Topic is locked. You cannot post in it."
    end
  end

  def invalid_emblem
    #TODO, posting with invalid emblem
  end

  def flood_control
    #TODO: basic flood control aka 'slow mode'. can't post more than once every 20 seconds
    #MAYBE: client project had an option to punish a user to a much, much longer flood control of one a day
  end

  def alert_control
    #TODO: forum had a functionality called "alert level" which if in the event of a raid, it would increase quality control such as length of time after registering until being able to post
  end

  def spam_test
    #TODO: starmen forum had a spam test where if you had less than 90% English characters, it would prevent you from posting. Mostly due to foreign language spam.
  end

  def allowed_to_edit
    #TODO
  end

  def allowed_to_split
    #TODO
  end

  def allowed_to_create
    #TODO
  end

  def add_to_latest_message_on_topic
    unless topic_id.blank?
      # option 1, the official rails way, but we need to reload in case funkyness happened on the topic
      #
      # topic.reload #force reload just in case
      # topic.latest_message_id = self.id
      # topic.save(validate:false) #skip validations
      #
      # or
      # option 2 just update_all on a topic id. Clunky, but good for force updating metadata
      # not sure if this is truly necessary?
      Topic.where(id:topic_id).update_all(latest_message_id:self.id)

      # also update the counters while we're at it.
      Topic.update_counters(topic_id, post_count:1, touch: :last_message)

      # TODO: Topic emblem stuff?
    end
  end

  def update_forum_post_count
    Forum.update_counters(forum.id,post_count:1, touch: :last_message)
  end

  def email_subscriptions
    #TODO: email subcriptions
  end

  def invalidate_caches
    #TODO: caches in general
  end

  def fix_forum_and_topic_after_delete
    #TODO
  end

  def fix_forum_and_topic_after_destroy
    #TODO
  end

  def can_edit?
    return true if Rails.env.development?
    false
  end

  def can_delete?
    return true if Rails.env.development?
    false
  end

  def can_undelete?
    return true if Rails.env.development?
    false
  end

  def can_infract?
    return true if Rails.env.development?
    false
  end

  def can_create?
    return true if Rails.env.development?
    false
  end

  def can_splitmerge?
    return true if Rails.env.development?
    false
  end

private
  def disablers(allowimages)
    [
      (:image unless allowimages),
      :del,
      :link_alias,
      :noparagraph_line_start,
      # client project allowed further disabling specific html features like bold, color, etc.
    ]
  end
end
