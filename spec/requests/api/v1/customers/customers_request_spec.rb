require "rails_helper"

describe "Customer Requests" do
  context "happy path" do
    describe "list a customer's subscriptions" do
      before do
        @subscription1 = create(:subscription)
        @subscription2 = create(:subscription)
        @subscription3 = create(:inactive_subscription)

        @customer = create(:customer)
        create(:customer_subscription, customer: @customer, subscription: @subscription1, status: 1)
        create(:customer_subscription, customer: @customer, subscription: @subscription2)
        create(:customer_subscription, customer: @customer, subscription: @subscription3)
      end

      it "returns a customer's subscriptions(active and cancelled)" do
        get "/api/v1/customers/#{@customer.id}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        #for the customer, subscription1 is cancelled and subscription 2 is active, both are included in response
        #subscription3 is inactive and not included in results
        expect(response_body.dig(:data, 0, :type)).to eq("subscription")
        expect(response_body.dig(:data, 0, :attributes, :title)).to eq(@subscription1.title)
        expect(response_body.dig(:data, 1, :attributes, :title)).to eq(@subscription2.title)
        expect(response_body.dig(:data, 0, :attributes, :price)).to eq(@subscription1.price)
        expect(response_body.dig(:data, 1, :attributes, :price)).to eq(@subscription2.price)
        expect(response_body.dig(:data, 0, :attributes, :frequency)).to eq(@subscription1.frequency)
        expect(response_body.dig(:data, 1, :attributes, :frequency)).to eq(@subscription2.frequency)
      end
    end
  end
end