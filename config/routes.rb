Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  root "blog#show_all"
  post "blog/create_blog"
  get "blog/add_blog", as: 'add_blog'
  get "blog/user_blog", as: 'user_blog'
  get "blog/update_blog/:id" => "blog#edit_blog", as: 'edit_blog'
  put "blog/update_blog/:id" => "blog#update", as: 'update_blog'
  get "blog/:id" => "blog#show", as: 'blog'
  delete "/blog/:id" => "blog#destroy", as: 'destroy_blog'

  resources :blogs do
    resources :comments, only: [:create, :destroy]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
