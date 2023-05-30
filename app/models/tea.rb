class Tea < ApplicationRecord
  has_many :tea_subscriptions, dependent: :destroy
end
