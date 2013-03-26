ShopifyIcollection::Application.routes.draw do
  match 'welcome' => 'home#welcome'
  match 'design' => 'home#design'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'auth/shopify/callback' => :show
    delete 'logout' => :destroy
  end

  root :to => 'home#index'
end
