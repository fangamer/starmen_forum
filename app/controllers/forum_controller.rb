class ForumController < ApplicationController
  def index
    @categories = Category.order(:order=>:asc).all.to_a

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
end
