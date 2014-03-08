WechatFans::Application.routes.draw do
  root "home#intro"
  
  get 'myself' => "home#myself"
  get 'idols/profile' => 'idols#profile'
  put 'idols/profile' => 'idols#update'
  resources :applies
  resources :songs

  namespace :cpanel do
    resources :users
    resources :songs
    resources :idols
  end
  
  namespace :wechat do
    resources :songs
    resource :response
  end
  
  devise_for :idols, :path => "account", :controllers => {
    :registrations => :account
  }
  
end
