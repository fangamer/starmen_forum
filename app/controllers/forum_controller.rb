class ForumController < ApplicationController
  before_action :require_forum, except: [:index,:category]
  before_action :require_topic, except: [:index,:category,:topiclist]
  after_action  :reset_expirations

private

  # get the forum by the nickname
  def require_forum
    if (params[:cat].blank? || params[:forum].blank?)
      raise ActiveRecord::RecordNotFound.new("Cannot find forum with that nickname")
    else
      @category = Category.find_by_nickname!(params[:cat])
      @forum = @category.forums.find_by_nickname!(params[:forum])
    end
    raise ActiveRecord::RecordNotFound.new("Cannot find forum with that nickname") if @forum.blank?
    @bookcrumbs << [@forum.name,@forum.URL]
  end

  def require_topic
    if params[:topic] =~ /\A\d+\z/
      @topic = Topic.find(params[:topic])
      @forum = @topic.forum
    else
      @topic = @forum.topics.find_by_permalink!(params[:topic])
    end
    #TODO: no bans from topic
    @bookcrumbs << [@topic.truncate_name,@topic.URL]
  end

  # pretty sure this prevents caching on the local browser when going back so it's always fresh?
  # not sure why this was there on the old forum
  def reset_expirations
    self.response.headers['Expires'] = 1.day.ago.to_formatted_s(:rfc822)
    self.response.headers['Cache-Control'] = "no-cache, no-store, private, must-revalidate"
  end

public

  def index
    @categories = Category.order(:order=>:asc).preload(:forums=>:sprite).all.to_a
    @page = "main"

    # backwards compat
    @sorted_forums = {}
    @categories.each{|cat| @sorted_forums[cat.id] = cat.forums}
    @categories.reject!{|x| @sorted_forums[x.id].length == 0}
    forums = @sorted_forums.values.map(&:to_a).flatten

    if @logged_in_user
      #TODO
    else
      #get list of collapsed stuff from session data
      collapsing_forum = session[:preferences]['collapse_forum'] rescue nil
      @subexpanded = false
    end
    #empty hash if collapsed forums are nil
    collapsing_forum = Hash.new if collapsing_forum.nil?

    #store all collapsed forums
    @forumexpanded = Hash.new
    forums.each{|forum| collapsing_forum[forum.id] != :expand ? @forumexpanded[forum.id] = false : @forumexpanded[forum.id] = true}
  end

  def category
    raise NotImplementedError
  end

  def topiclist
    @topics = @forum.topics.reorder(sticky: :desc, last_message: :desc).preload(:sprite) # reorder necessary to prevent default order
    #TODO: mark forum as read
    @page = "topics" # set css
    @page_number = (params[:page] || 1).to_i
    @topics = @topics.limit(50).offset((@page_number-1)*50) # basic pages for now
    #TODO: offset is VERY slow and needs optimization

    if @logged_in_user
      topic_ids = @topics.map(&:id)
      @topicreads = Hash.new
      Read.where(user_id:@logged_in_user.id,topic_id:topic_ids).each do |read|
        @topicreads[read.topic_id] = read
      end
    end
  end

  def topic
    # no bans from forum
    # redirect to unread page logic
    # page number logic, below is stubbed
    @page_number = (params[:page] || 1).to_i
    @messages = @topic.messages.order(:created_at).preload(:creator=>:sprite).limit(50).offset((@page_number-1)*50).to_a #TODO: offset is VERY slow and needs optimization
    # remove the deleted messages from this view
    @messages.reject!{|x| x.deleted} unless @forum.is_moderator? if @forum

    if @logged_in_user
      Read.upsert({last_view:Time.now}, unique_by: :index_reads_on_user_id_and_topic_id)
    end
    # update forum reads
    # update topic views, unless was already last visited topic

    # set css
    @page = "posts"

    # quick message base
    @message = @topic.messages.new
  end
end
