Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  #ネスト
  resources :post_images, only:[:new, :create, :index, :show, :destroy] do
    resource :favorites, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]
  end


  resources :users, only:[:show, :edit, :update, :index] do
  resource :relationships, only: [:create, :destroy, :index]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
  get 'relationships' => 'relationships#index'
  end

  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'

end
