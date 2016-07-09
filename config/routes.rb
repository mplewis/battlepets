Rails.application.routes.draw do
  root to: 'home#index'
  resources :pets do
    member do
      post 'train'
    end
  end
end
