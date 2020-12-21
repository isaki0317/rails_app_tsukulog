Rails.application.routes.draw do

  devise_for :end_users, controllers: {
    sessions: 'end_users/sessions',
    registrations: 'end_users/registrations'
  }
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'end_users/sessions#new_guest'
  end

  devise_scope :admin do
    post 'admin/guest_sign_in', to: 'admin/sessions#new_guest'
  end
  #チャット機能に関するAdmin側のルーティングを追加する必要がある
  namespace :admin do
    get 'top' => 'homes', as: 'top'
    get 'search' => 'searchs', as: 'search'
    resources :chats, only: [:destroy] do
    end
    # delete 'destroy_room' => 'admin/chats#destroy_room', on: :member
    resources :genres, only: [:index, :create, :updete, :show]
    resources :contacts, only: [:index, :show, :update]
    resources :comments, only: [:destroy]
    resources :posts, only: [:index, :show, :update, :destroy, :edit]
    resources :end_users, only: [:index, :show, :edit, :update, :destroy] do
      resource :chats, only: [:show]
      get 'blockers' => 'blocks#index'
    end
  end

  scope module: :end_user do
    resources :chats, only: [:create, :show]  #showの部分を確認する
    root 'homes#top'
    get 'about' => 'homes#about'
    get 'search' => 'searchs#search', as: 'search'
    delete 'notifications/destroy_all' => 'notifications#destroy_all'
    get 'notifications' => 'notifications#index'
    resources :end_users, only: [:show, :edit, :update] do
      resource :blocks, only: [:create, :destroy]
      get 'blockers' => 'blocks#index', on: :collection
      resource :relationships, only: [:create, :destroy]
      collection do
  	    patch 'out'
        get 'quit'
  	  end
    end
    resources :contacts, only: [:create]
    resources :posts do
      resources :works, only: [:destroy]
      resources :materials, only: [:destroy]
      resources :comments, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
