class ForumController < ApplicationController
  before_action :require_forum, except: [:index,:category,:collapse_forum,:collapse_category]
  before_action :require_topic, except: [:index,:category,:topiclist,:collapse_forum,:collapse_category]
  after_action  :reset_expirations

  def index
    @categories = Category.order(:order=>:asc).preload(:forums=>:sprite).all.to_a
    @page = "main"

    # backwards compat
    @sorted_forums = {}
    @categories.each{|cat| @sorted_forums[cat.id] = cat.forums}
    @categories.reject!{|x| @sorted_forums[x.id].length == 0}
    forums = @sorted_forums.values.map(&:to_a).flatten
    # TODO: Reject forums user does not have access to

    if @logged_in_user
      #TODO: collapse category
      #TODO: collapse forum
      @old_last_visit = @logged_in_user.last_visit || Time.now
      @logged_in_user.update_attribute(:last_visit,Time.now)

      @since_last_visit = Hash.new(0)
      @categories.each do |cat|
        forum_ids = @sorted_forums[cat.id].map(&:id)
        @since_last_visit[cat.id] = Message.with_forum_ids(forum_ids).where(deleted:[false,nil]).where("created_at > ?",@old_last_visit).count
      end

      # raise Message.with_forum_ids(1).where(.count.inspect

      #TODO: topic subscriptions
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

  def collapse_forum
    raise NotImplementedError
  end

  def collapse_category
    raise NotImplementedError
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

  def message
    if @topic
      @message = @topic.messages.find(params[:id])
    else
      @message = Message.find(params[:id])
    end
    #TODO: If not in forum you can read, also return not found

    # holy crap optimize this
    page_number = (@topic.messages.select(:id).map(&:id).index(@message.id)/50)+1
    redirect_to action: :topic, page: page_number, anchor: "post#{@message.id}"
  end
end
