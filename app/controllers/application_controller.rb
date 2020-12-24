class ApplicationController < ActionController::Base
  before_action :set_site
  before_action :backwards_compatibility
  rescue_from NotImplementedError, with: :not_implemented

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

  helper_method def fangamer_ad
    ""
  end

  # TODO: permissions
  helper_method def liu_is_modadmin?
    false
  end
end
