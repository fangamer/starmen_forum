class ForumController < ApplicationController
  before_action :require_forum, except: [:index,:category]
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

  # pretty sure this prevents caching on the local browser when going back so it's always fresh?
  # not sure why this was there on the old forum
  def reset_expirations
    self.response.headers['Expires'] = 1.day.ago.to_formatted_s(:rfc822)
    self.response.headers['Cache-Control'] = "no-cache, no-store, private, must-revalidate"
  end

public

  def index
    @categories = Category.order(:order=>:asc).all.to_a
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
    #TODO: get topics reads
    @page = "topics" # set css
    #TODO: page numbering
    @topics = @topics.limit(50) # basic pages for now
  end
end
