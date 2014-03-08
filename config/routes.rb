WechatFans::Application.routes.draw do
  root "home#intro"
  
  get 'myself' => "home#myself"
  
  resources :applies
  resources :songs

  namespace :cpanel do
    resources :users
    resources :songs
    resources :idols
  end
  
  namespace :wechat do
    resources :songs
  end
  
  devise_for :idols, :path => "account", :controllers => {
    :registrations => :account
  }
  
end
