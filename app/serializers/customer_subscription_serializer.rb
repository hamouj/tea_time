class CustomerSubscriptionSerializer
  include JSONAPI::Serializer
  attributes :id, :customer_id, :subscription_id, :status
end
