class ApplicationController < ActionController::Base
  before_action :set_site
  before_action :backwards_compatibility

  def set_site
    @site = Site.new
  end

  def backwards_compatibility
    @neededjavascripts = []
    @bookcrumbs = [[]]
  end

  helper_method def fangamer_ad
    ""
  end

  # TODO: permissions
  helper_method def liu_is_modadmin?
    false
  end
end
