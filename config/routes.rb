Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'forum/:cat/:forum/:topic/reply', :controller=>"forum/reply", :action=>"index", :type=>"reply" #TEMPORARY ONLY
  get 'forum/:cat/:forum/:topic', :controller=>"forum", :action=>"topic"
  get 'forum/:cat/:forum',:controller=>"forum",:action=>"topiclist"
  get 'forum/:cat',:controller=>"forum",:action=>"category"
  get 'forum/', controller:'forum', action:'index'

  root 'forum#index'
end
