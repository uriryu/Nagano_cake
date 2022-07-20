Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  namespace :admin do
    patch '/admin/orders_details/:id' => 'admin/orders_details#update'
  end

  namespace :admin do
    resources :orders, only: [:show, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :genres, only: [:new, :index, :create, :edit, :update]

    resources :items, only: [:new, :index, :show, :edit, :create, :update]

    resources :orders_details, only: [:update]
    get '/orders' => 'orders_details#index'


    root to: "homes#top"
  end

  # moduleはURLは変えたくないが、パスは変えたいときに使える!今回はpublicをパスの方に入れたかったので利用した
  scope module: :public do
    resources :address, only: [:index, :edit, :create, :update, :destroy]

    resources :orders, only: [:new, :index, :show, :create]
    get '/orders/complete' => 'public/orders#complete'
    post '/orders/confirm' => 'public/orders#comfirm'


    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete '/cart_items/destroy_all' => 'public/cart_items#destroy_all'

    resource :customers, only: [:show, :edit, :update]
    get '/customers/unsubscribe' => 'public/customers#unsubscribe'
    patch '/customers/withdraw' => 'public/customers#withdraw'

    resources :items, only: [:index, :show]
  end

    root to: 'public/homes#top'
    get '/about' => 'public/homes#about', as: 'about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
