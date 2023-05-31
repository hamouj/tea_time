require "rails_helper"

describe "Customer Subscription Requests" do
  context "happy path" do
    describe "create customer_subscription" do
      it "creates a new customer subscription" do
        customer = create(:customer)
        subscription = create(:subscription)

        customer_subscription_params = {
          customer_id: customer.id,
          subscription_id: subscription.id
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/customer_subscription", headers:, params: JSON.generate(customer_subscription_params)
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

  context "sad path/edge case" do
    describe "create customer_subscription" do
      before do
        @customer = create(:customer)
        @subscription = create(:subscription)
      end
      context "incomplete/missing params" do
        it "returns an error when the request is missing a subscription id" do
          customer_subscription_params = {
            customer_id: @customer.id
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customer_subscription", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :status)).to eq(400)
          expect(response_body.dig(:errors, 0, :title)).to eq("validation error")
          expect(response_body.dig(:errors, 0, :detail, 0)).to eq("Validation failed: Subscription must exist")
        end

        it "returns an error when the request is missing a customer id" do
          customer_subscription_params = {
            subscription_id: @subscription.id
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customer_subscription", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail, 0)).to eq("Validation failed: Customer must exist")
        end

        it "returns an error when the request is empty" do
          post "/api/v1/customer_subscription"

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail, 0)).to eq("param is missing or the value is empty: customer_subscription")
        end
      end

      context "customer/subscription does not exist" do
        it "returns an error when the customer does not exist" do
          customer_subscription_params = {
            customer_id: 17894578902387,
            subscription_id: @subscription.id
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customer_subscription", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail, 0)).to eq("Validation failed: Customer must exist")
        end

        it "returns an error when the customer does not exist" do
          customer_subscription_params = {
            customer_id: @customer.id,
            subscription_id: 127890934875
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customer_subscription", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail, 0)).to eq("Validation failed: Subscription must exist")
        end
      end

      context "incorrect data type within request params" do
        it "returns an error when the subscription id contains letters/symbols" do
          customer_subscription_params = {
            customer_id: @customer.id,
            subscription_id: "12A&3f%"
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customer_subscription", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail, 0)).to eq("Validation failed: Subscription must exist")
        end
      end
    end
  end
end
