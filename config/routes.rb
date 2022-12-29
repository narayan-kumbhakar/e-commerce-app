Rails.application.routes.draw do
  resources :categories
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users
  post '/auth/login', to: 'authentication#login'

  # About Shopping cart
  get 'carts/:id' => 'carts#show', as: 'cart'
  delete 'carts/:id' => 'carts#destroy'

  post 'cart_items/:id/add' => 'cart_items#add_quantity', as: 'cart_item_add'
  post 'cart_items/:id/reduce' => 'cart_items#reduce_quantity', as: 'cart_item_reduce'
  post 'cart_items' => 'cart_items#create'
  get 'cart_items/:id' => 'cart_items#show', as: 'cart_item'
  delete 'cart_items/:id' => 'cart_items#destroy'

  resources :products
  get 'orders/:user_id/ordered_products' => 'orders#ordered_products'
  resources :orders do
    resources :payments
  end
end
 