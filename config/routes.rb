Rails.application.routes.draw do
  devise_for :users


  resources :projects
  root 'static_pages#home'
end
