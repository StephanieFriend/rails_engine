Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find_all", to: "search#index"
        get "/find", to: "search#show"
      end
      namespace :items do
        get "/find_all", to: "search#index"
        get "/find", to: "search#show"
      end
      resources :items, except: [:new, :edit]
      resources :merchants, except: [:new, :edit]
      get "/items/:item_id/merchant", to: "merchant_items#show"
      get "/merchants/:merchant_id/items", to: "merchant_items#index"
    end
  end
end
