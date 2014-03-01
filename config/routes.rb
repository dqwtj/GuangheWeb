WechatFans::Application.routes.draw do
  devise_for :idols
  
  root "home#intro"
  
  resources :applies

  namespace :cpanel do
    resources :users
    resources :songs
    resources :idols
  end
  
  namespace :wechat do
    
  end
  
end
