Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get '/post_image/hashtag/:name' => 'post_images#hashtag'
  get '/post_image/hashtag' => 'post_images#hashtag'
  #get '/post_images/search' => 'post_images#search'
  #post '/post_images/search' => 'post_images#search'

  #ネスト
  resources :post_images, only:[:new, :create, :index, :show, :destroy] do
    resource :favorites, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]

    collection do
      get 'search'
    end
  end


  resources :users, only:[:show, :edit, :update, :index]

end
