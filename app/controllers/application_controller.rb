class ApplicationController < ActionController::Base
  before_action :set_site
  before_action :backwards_compatibility
  before_action :set_logged_in_user, if:->{!session[:logged_in_user].blank?}
  before_action :no_superbanned_users
  rescue_from NotImplementedError, with: :not_implemented
  rescue_from StarmenForum::LoginRequired, with: :login_required
  rescue_from CanCan::AccessDenied, with: :four_oh_four

  def set_site
    @site = Site.new
  end

  def backwards_compatibility
    @neededjavascripts = []
    @bookcrumbs = [[@site.name,@site.root,@site.class_name],["forum","/forum"]]
  end

  def not_implemented
    render action: :not_implemented
  end

  def login_required
    # TODO: better logic
    render action: :login_required
  end

  def four_oh_four
    @forum = nil # clear out in case it tries using it to render the 404 error
    @category = nil
    @topic = nil
    @message = nil
    render action: :four_oh_four
  end

  def set_logged_in_user
    @logged_in_user = User.find(session[:logged_in_user])
  end

  helper_method def fangamer_ad
    ""
  end

  # TODO: permissions
  helper_method def liu_is_modadmin?
    false
  end

  def no_superbanned_users
    render partial:"banned" if @logged_in_user.try(:banned)
  end

private

  # get the forum by the nickname
  def require_forum
    if (params[:cat].blank? || params[:forum].blank?)
      raise ActiveRecord::RecordNotFound.new("Cannot find forum with that nickname")
    else
      @category = Category.find_by_nickname!(params[:cat])
      @forum = @category.forums.find_by_nickname!(params[:forum])
    end
    authorize! :read, @forum
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

  def require_login
    raise StarmenForum::LoginRequired if @logged_in_user.nil?
  end

  # pretty sure this prevents caching on the local browser when going back so it's always fresh?
  # not sure why this was there on the old forum
  def reset_expirations
    self.response.headers['Expires'] = 1.day.ago.to_formatted_s(:rfc822)
    self.response.headers['Cache-Control'] = "no-cache, no-store, private, must-revalidate"
  end

  def current_ability
    @current_ability ||= Ability.new(@logged_in_user)
  end
end
