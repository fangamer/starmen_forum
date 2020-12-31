Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'forum/:cat/:forum/:topic/reply', :controller=>"forum/reply", :action=>"index", :type=>"reply" #TEMPORARY ONLY
  get 'forum/:cat/:forum/:topic/page/:page', :controller=>"forum", :action=>"topic"
  get 'forum/:cat/:forum/:topic', :controller=>"forum", :action=>"topic"
  get 'forum/:cat/:forum',:controller=>"forum",:action=>"topiclist"
  get 'forum/:cat',:controller=>"forum",:action=>"category"
  get 'forum/', controller:'forum', action:'index'

  get 'login/' => 'login#login'
  get 'login/login_oauth' => 'login#login' #backwards compat
  post 'login/' => 'login#do_login'
  get 'login/register' => 'login#register'
  post 'login/register' => 'login#do_register'
  get 'login/change_password' => 'login#change_password'
  post 'login/change_password' => 'login#do_change_password'
  get 'login/reset_password' => 'login#reset_password'
  post 'login/reset_password' => 'login#do_reset_password'
  get 'login/validate/:validate_key' => 'login#validate'
  delete 'login/logout' => 'login#logout'

  root 'forum#index'
end
