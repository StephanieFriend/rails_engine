Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit] do
        resources :merchant, only: [:index], to: 'merchants#show'
      end
      resources :merchants, except: [:new, :edit] do
        resources :items, only: [:index]
      end
    end
  end
end
