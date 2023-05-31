require 'rails_helper'

describe "Customer Subscription Requests" do
  context 'happy path' do
    describe 'customer_subscription create' do
      it 'creates a new customer subscription' do
        customer = create(:customer)
        subscription = create(:subscription)

        customer_subscription_params = ({
                                    customer_id: customer.id,
                                    subscription_id: subscription.id
        })

        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v1/customer_subscription", headers: headers, params: JSON.generate(customer_subscription_params)
        created_customer_subscription = CustomerSubscription.last

        expect(response).to be_successful
        expect(response.status).to eq 201

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.dig(:data, :attributes, :id)).to eq(created_customer_subscription.id)
        expect(response_body.dig(:data, :attributes, :customer_id)).to eq(created_customer_subscription.customer_id)
        expect(response_body.dig(:data, :attributes, :subscription_id)).to eq(created_customer_subscription.subscription_id)
      end
    end
  end
end
