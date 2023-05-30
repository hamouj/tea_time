class Subscription < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  belongs_to :tea

  enum status: { "active" => 0, "cancelled" => 1 }
end
