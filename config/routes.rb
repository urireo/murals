Rails.application.routes.draw do

  resources :users
  #resources :replies

  #resources :posts do
  #  resources :comments
  #end

  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :replies
  end
  resources  :replies

  root to: 'posts#index'

  #route  get 'pages/home'
  get '/pages/about'
  get '/pages/home'




#  post '/comments/:comment_id/replies(.:format)', to 'replies#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
