class Customer < ApplicationRecord
  has_many :customer_subscriptions, dependent: :destroy
  has_many :subscriptions, through: :customer_subscriptions

  def live_subscriptions
    subscriptions.merge(Subscription.live)
  end
end
