WechatFans::Application.routes.draw do
  root "home#intro"
  
  resources :applies

  namespace :cpanel do
    resources :users
    resources :songs
    resources :idols
  end
  
  namespace :wechat do
    
  end
  
  devise_for :idols, :path => "account", :controllers => {
      :registrations => :account
   }
  
end
