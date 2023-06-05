require "rails_helper"

describe "Customer Requests" do
  context "happy path" do
    describe "customer show endpoint" do
      before do
        @subscription1 = create(:subscription)
        @subscription2 = create(:subscription)
        @subscription3 = create(:inactive_subscription)

        @customer = create(:customer)
        @customer2 = create(:customer)

        create(:customer_subscription, customer: @customer, subscription: @subscription1, status: 1)
        create(:customer_subscription, customer: @customer, subscription: @subscription2)
        create(:customer_subscription, customer: @customer, subscription: @subscription3)
      end

      it "returns a customer's subscriptions(active and cancelled)" do
        get "/api/v1/customers/#{@customer.id}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        # for the customer, subscription1 is cancelled and subscription 2 is active, both are included in response
        # subscription3 is inactive and not included in results
        expect(response_body.dig(:data, :attributes, :subscriptions, 0, :title)).to eq(@subscription1.title)
        expect(response_body.dig(:data, :attributes, :subscriptions, 1, :title)).to eq(@subscription2.title)
        expect(response_body.dig(:data, :attributes, :subscriptions, 0, :price)).to eq(@subscription1.price)
        expect(response_body.dig(:data, :attributes, :subscriptions, 1, :price)).to eq(@subscription2.price)
        expect(response_body.dig(:data, :attributes, :subscriptions, 0, :frequency)).to eq(@subscription1.frequency)
        expect(response_body.dig(:data, :attributes, :subscriptions, 1, :frequency)).to eq(@subscription2.frequency)
        expect(response_body.dig(:data, :attributes, :subscriptions, 0, :status)).to eq("live")
        expect(response_body.dig(:data, :attributes, :subscriptions, 1, :status)).to eq("live")
      end

      it "returns an empty array when a customer has no subscriptions" do
        get "/api/v1/customers/#{@customer2.id}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.dig(:data, :attributes, :subscriptions)).to eq([])
      end

      it "returns a single subscription in an array" do
        create(:customer_subscription, customer: @customer2, subscription: @subscription2)

        get "/api/v1/customers/#{@customer2.id}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.dig(:data, :attributes, :subscriptions, 0, :title)).to eq(@subscription2.title)
        expect(response_body.dig(:data, :attributes, :subscriptions, 0, :price)).to eq(@subscription2.price)
        expect(response_body.dig(:data, :attributes, :subscriptions, 0, :frequency)).to eq(@subscription2.frequency)
        expect(response_body.dig(:data, :attributes, :subscriptions, 0, :status)).to eq("live")
      end
    end
  end

  context "sad path/edge case" do
    describe "customer show endpoint" do
      before do
        @subscription1 = create(:subscription)
        @subscription2 = create(:subscription)
        @subscription3 = create(:inactive_subscription)

        @customer = create(:customer)
        create(:customer_subscription, customer: @customer, subscription: @subscription1, status: 1)
        create(:customer_subscription, customer: @customer, subscription: @subscription2)
        create(:customer_subscription, customer: @customer, subscription: @subscription3)
      end

      context "invalid customer ID" do
        it "returns an error when the customer ID does not exist" do
          get "/api/v1/customers/34789657893"

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :title)).to eq("record not found")
          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Customer with 'id'=34789657893")
        end

        it "returns an error when the customer ID contains letters/symbols" do
          get "/api/v1/customers/34Abj&k"

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Customer with 'id'=34Abj&k")
        end
      end
    end
  end
end
