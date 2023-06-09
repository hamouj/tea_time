class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :tea_subscriptions, dependent: :destroy

  enum status: { "live" => 0, "inactive" => 1 }
end
