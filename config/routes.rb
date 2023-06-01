Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :customer_subscriptions, only: [:create, :update]
      resource :customers, only: [:show]
    end
  end
end
