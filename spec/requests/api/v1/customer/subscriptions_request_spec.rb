require "rails_helper"

describe "Customer Subscription Requests" do
  context "happy path" do
    describe "create customer subscription" do
      it "creates a new customer subscription and returns the created resource" do
        customer = create(:customer)
        subscription = create(:subscription)

        customer_subscription_params = {
          subscription_id: subscription.id
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v1/customers/#{customer.id}/subscriptions", headers:, params: JSON.generate(customer_subscription_params)
        created_customer_subscription = CustomerSubscription.last

        expect(response).to be_successful
        expect(response.status).to eq 201

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.dig(:data, :attributes, :id)).to eq(created_customer_subscription.id)
        expect(response_body.dig(:data, :attributes, :customer_id)).to eq(created_customer_subscription.customer_id)
        expect(response_body.dig(:data, :attributes, :subscription_id)).to eq(created_customer_subscription.subscription_id)
        expect(response_body.dig(:data, :attributes, :status)).to eq("active")
      end
    end

    describe "cancel customer subscription" do
      before do
        @customer = create(:customer)
        @subscription = create(:subscription)
        @customer_subscription = create(:customer_subscription, customer: @customer, subscription: @subscription)
      end

      it "cancels a customer subscription and returns the updated resource" do
        customer_subscription_params = {
          status: "cancelled"
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers:, params: JSON.generate(customer_subscription_params)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.dig(:data, :id)).to eq(@customer_subscription.id.to_s)
        expect(response_body.dig(:data, :attributes, :status)).to eq("cancelled")
      end

      it "returns the unchanged resource when the sent status is the same as current status" do
        customer_subscription_params = {
          status: "active"
        }

        headers = { "CONTENT_TYPE" => "application/json" }

        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers:, params: JSON.generate(customer_subscription_params)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.dig(:data, :id)).to eq(@customer_subscription.id.to_s)
        expect(response_body.dig(:data, :attributes, :status)).to eq("active")
      end

      it "returns the unchanged resource when no request body is sent" do
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.dig(:data, :id)).to eq(@customer_subscription.id.to_s)
        expect(response_body.dig(:data, :attributes, :status)).to eq("active")
      end
    end
  end

  context "sad path/edge case" do
    describe "create customer subscription" do
      before do
        @customer = create(:customer)
        @subscription = create(:subscription)
      end

      context "missing params" do
        it "returns an error when the request is empty" do
          post "/api/v1/customers/#{@customer.id}/subscriptions"

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Subscription without an ID")
        end
      end

      context "customer/subscription does not exist" do
        it "returns an error when the customer does not exist" do
          customer_subscription_params = {
            subscription_id: @subscription.id
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customers/378949567834/subscriptions", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Validation failed: Customer must exist")
        end

        it "returns an error when the subscription does not exist" do
          customer_subscription_params = {
            subscription_id: 127890934875
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customers/#{@customer.id}/subscriptions", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Subscription with 'id'=127890934875")
        end
      end

      context "incorrect data type" do
        it "returns an error when the subscription id contains letters/symbols" do
          customer_subscription_params = {
            subscription_id: "12A&3f%"
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customers/#{@customer.id}/subscriptions", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Subscription with 'id'=12A&3f%")
        end

        it "returns an error when the customer id contains letters/symbols" do
          customer_subscription_params = {
            subscription_id: @subscription.id
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customers/3789&jhdf/subscriptions", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Validation failed: Customer must exist")
        end
      end

      context "inactive subscription" do
        it "returns an error when the subscription is inactive" do
          subscription2 = create(:inactive_subscription)

          customer_subscription_params = {
            subscription_id: subscription2.id
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          post "/api/v1/customers/3789&jhdf/subscriptions", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(400)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Record invalid")
        end
      end
    end

    describe "cancel customer subscription" do
      before do
        @customer = create(:customer)
        @subscription = create(:subscription)
        @customer_subscription = create(:customer_subscription, customer: @customer, subscription: @subscription)
      end

      context "customer subscription ID does not exist" do
        it "returns an error when the subscription ID does not exist" do
          customer_subscription_params = {
            status: "cancelled"
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          patch "/api/v1/customers/#{@customer.id}/subscriptions/1267894587", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :title)).to eq("record not found")
          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Subscription with 'id'=1267894587")
        end

        it "returns an error when the customer ID does not exist" do
          customer_subscription_params = {
            status: "cancelled"
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          patch "/api/v1/customers/12789347985/subscriptions/#{@subscription.id}", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :title)).to eq("record not found")
          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Customer with 'id'=12789347985")
        end

        it "returns an error when the customer ID contains letters/symbols" do
          customer_subscription_params = {
            status: "cancelled"
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          patch "/api/v1/customers/347A&jhd/subscriptions/#{@subscription.id}", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Customer with 'id'=347A&jhd")
        end

        it "returns an error when the subscription ID contains letters/symbols" do
          customer_subscription_params = {
            status: "cancelled"
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          patch "/api/v1/customers/#{@customer.id}/subscriptions/789#28ad", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find Subscription with 'id'=789")
        end

        it "returns an error when the customer subscription does not exist" do
          subscription2 = create(:subscription)

          customer_subscription_params = {
            status: "cancelled"
          }

          headers = { "CONTENT_TYPE" => "application/json" }

          patch "/api/v1/customers/#{@customer.id}/subscriptions/#{subscription2.id}", headers:, params: JSON.generate(customer_subscription_params)

          expect(response).to_not be_successful
          expect(response.status).to eq(404)

          response_body = JSON.parse(response.body, symbolize_names: true)

          expect(response_body.dig(:errors, 0, :detail)).to eq("Couldn't find CustomerSubscription with [WHERE \"customer_subscriptions\".\"customer_id\" = $1 AND \"customer_subscriptions\".\"subscription_id\" = $2]")
        end
      end
    end
  end
end
