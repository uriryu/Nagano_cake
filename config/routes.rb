Rails.application.routes.draw do
  namespace :admin do
    patch '/admin/orders_details/:id' => 'admin/orders_details#update'
  end
  
  namespace :admin do 
    resources :orders, only: [:show, :update]

    resources :customers, only: [:index, :show, :edit, :update]
    
    resources :genres, only: [:index, :create, :edit, :update]

    resources :items, only: [:new, :index, :show, :edit, :create, :update]

    root to: "homes#top"
  end

    resources :address, only: [:index, :edit, :create, :update, :destroy]

    resources :orders, only: [:new, :index, :show, :create]
    get '/orders/complete' => 'public/orders#complete'
    post '/orders/confirm' => 'public/orders#comfirm'
    

    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete '/cart_items/destroy_all' => 'public/cart_items#destroy_all'
  
    resources :customers, only: [:show, :edit, :update]
    get '/customers/unsubscribe' => 'public/customers#unsubscribe'
    patch '/customers/withdraw' => 'public/customers#withdraw'

    resources :items, only: [:index, :show]

  
    root to: "homes#top"
    get '/about' => 'public/homes#about'

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
