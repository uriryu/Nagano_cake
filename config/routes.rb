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
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:index]
    end

    resources :customers, only: [:index, :show, :update]
    get 'customers/:id/edit' => 'customers#edit', as: :customer_edit
    # updateより後にするため、editを手作りしてもらった。URLでどこからかぐちゃぐちゃなものが入ってきて、editを表示している状態。

    resources :genres, only: [:new, :index, :create, :edit, :update]

    resources :items, only: [:new, :index, :show, :edit, :create, :update]


    resources :order_details, only: [:update]


    root to: "homes#top"
  end

  # moduleはURLは変えたくないが、パスは変えたいときに使える!今回はpublicをパスの方に入れたかったので利用した
  scope module: :public do
    # public doでくくっているときは =>のあと、/publicは不要

    get '/orders/complete' => 'orders#complete'
    post '/orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new, :index, :show, :create]
    # resourcesで定義したルートより前に自作URLを置かないとorder/:idの方にヒットしてしまい、id=completeでshowを呼び出すのように、別のページを呼び出してしまう。


    resources :cart_items, only: [:index, :update, :destroy, :create] do
    collection do
      delete 'destroy_all' => 'cart_items#destroy_all'
      end
    end

    get '/customers/my_page' => 'customers#show'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/information' => 'customers#update'
    patch '/customers/withdraw' => 'customers#withdraw'

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    # ネストするときとは、URLで"特定のするもの"があるときにネストする。
    # 今回customersの中にネストを入れるとURLの方にcustomer_idが追加される。
    # bookersのときは"誰の","どの投稿"に"コメントを書く"というように判別しなくてはならなかった為ネストを入れていた。

    resources :items, only: [:index, :show]
  end

    root to: 'public/homes#top'
    get '/about' => 'public/homes#about', as: 'about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
