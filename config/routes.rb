ShopifyIcollection::Application.routes.draw do
  get "billing/index"

  get "billing/confirm"

  resources :shops, :only => [:edit, :update]


  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'auth/shopify/callback' => :show
    delete 'logout' => :destroy
  end

  root :to => 'home#index'
end
