class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  enum status: { "active" => 0, "cancelled" => 1 }, _default: :active
end
