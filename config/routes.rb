WechatFans::Application.routes.draw do
  root "home#intro"
  
  get 'console' => "console#myself"
  get 'admission' => "home#admission"
  get 'producer' => 'home#producer' 
  get 'billboard' => 'home#billboard'
  get 'idols/profile' => 'idols#profile'
  put 'idols/profile' => 'idols#update'
  resources :applies
  resources :songs
  resources :idols, only: [:index]

  namespace :cpanel do
    resources :users
    resources :songs
    resources :idols
  end
  
  namespace :wechat do
    resources :songs
    resource :response
    resource :activity
  end
  
  devise_for :idols, :path => "account", :controllers => {
    :registrations => :account
  }
  
end
