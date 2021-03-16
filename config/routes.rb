Rails.application.routes.draw do
  namespace :api do
    resources :products
    resources :contacts
  end
end
