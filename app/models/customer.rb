class Customer < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
end
