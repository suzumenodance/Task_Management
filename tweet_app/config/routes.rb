Rails.application.routes.draw do
  #homeルート
  get "/" => 'home#top'
  get "about" => 'home#about'

  #postsルート
  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  post 'posts/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'
  get 'posts/:id' => 'posts#show'#必ず一番下に記述

  #usersルート
  get 'users/index'
  get 'users/signup'
  post 'users/create' => 'users#create'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'
  get 'users/:id' => 'users#show'#必ず一番下に記述
end
