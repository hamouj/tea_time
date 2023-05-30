class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  belongs_to :tea
end
