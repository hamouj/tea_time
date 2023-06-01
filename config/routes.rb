Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :customer_subscription, only: [:create, :update]
    end
  end
end
