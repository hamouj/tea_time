class CustomerSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :address

  attribute :subscriptions do |customer|
    customer.live_subscriptions
  end
end
