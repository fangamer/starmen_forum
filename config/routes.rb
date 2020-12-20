Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'forum/:cat',:controller=>"forum",:action=>"category"
  get 'forum/', controller:'forum', action:'index'

  root 'forum#index'
end
