class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  belongs_to :tea
end
