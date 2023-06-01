require "rails_helper"

describe "Customer Requests" do
  context "happy path" do
    describe "list a customer's subscriptions" do
      before do
        @subscription1 = create(:subscription)
        @subscription2 = create(:subscription)
        @subscription3 = create(:subscription)

        @customer1 = create(:customer)
        create(:customer_subscription, customer: @customer1, subscription: @subscription1)
        create(:customer_subscription, customer: @customer1, subscription: @subscription2, status: 1)

        @customer2 = create(:customer)
        create(:customer_subscription, customer: @customer2, subscription: @subscription1, status: 1)
        create(:customer_subscription, customer: @customer2, subscription: @subscription2)
        create(:customer_subscription, customer: @customer2, subscription: @subscription3)
      end

      it 'returns a customer subscriptions(active and cancelled)' do
        get "/api/v1/customers/#{@customer1.id}"

        expect(result).to be_successful
        expect(result.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)
        require 'pry'; binding.pry
      end
    end
  end
end