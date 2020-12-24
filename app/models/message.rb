class Message < ApplicationRecord
  include BackwardsCompat

  belongs_to :creator, class_name: "User", foreign_key: "user_id", inverse_of: :messages
  belongs_to :topic, inverse_of: :messages
  def infraction; nil; end #stub has_one :infraction, :dependent=>:destroy
  has_and_belongs_to_many :searchwords, :uniq =>true
  belongs_to :poll
  def forumAttachments; nil; end #stub has_many :forumAttachments
  has_many :thumbs,:class_name=>"Thumbs", :dependent=>:destroy
  has_many :submissions
  belongs_to :emblem
  has_many :reports, :dependent=>:destroy
  has_one :report,->{where(resolved_at:nil)}

  validates_presence_of :body,:user_id
  validates_format_of :body, :with => /[a-z]/i,:message=>"must contain at least one letter."
  # more custom validations such as can_create? and spam_test

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
end
