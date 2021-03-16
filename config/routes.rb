Rails.application.routes.draw do
  namespace :api do
    resources :products
    resources :contacts
    resources :categories
  end
end
