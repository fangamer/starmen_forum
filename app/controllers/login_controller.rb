class LoginController < ApplicationController
  before_action :insecure_in_production, only:[:do_login], if:->{Rails.env.production?}
  before_action :gotta_like_give_me_a_name_and_password, only:[:do_login]

private
  def valid_return(url)
    URI(url.to_s).host == request.host
  rescue ArgumentError, URI::Error
    false
  end

  def insecure_in_production
    render html:%(<div id="content"><div class="wrapper"><div id="main"><h3 style='color:#f00;font-size:300%;'>LOGIN CURRENTLY INSECURE!</h3></div></div></div>).html_safe, layout:true
  end

  def gotta_like_give_me_a_name_and_password
    if params[:user].try(:[],:name).blank?
      flash[:error] = "Need a name."
      redirect_back fallback_location:{action: :login}
    end
  end

public

  def login
    # setup referer if we clicked login
    referer = request.headers["Referer"]
    if !session[:login_return] && valid_return(referer)
      session[:login_return] = referer
    end
  end

  def do_login
    @logged_in_user = User.find_by_name(params[:user][:name])
    if !@logged_in_user
      flash[:error] = "Invalid Username/Password"
      return redirect_to action: :login
    end
    session[:logged_in_user] = @logged_in_user.id

    if valid_return(session[:login_return])
      redirect_to session[:login_return]
    else
      redirect_to :root
    end
    session.delete(:login_return)
  end

  def register
    raise NotImplementedError
  end

  def do_register
    raise NotImplementedError
  end

  def change_password
    raise NotImplementedError
  end

  def do_change_password
    raise NotImplementedError
  end

  def reset_password
    raise NotImplementedError
  end

  def do_reset_password
    raise NotImplementedError
  end

  def validate
    raise NotImplementedError
  end

  def logout
    reset_session
    redirect_back fallback_location:{action: :login}
  end
end
