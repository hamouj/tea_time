class Api::V1::Customer::SubscriptionsController < ApplicationController
  before_action :check_subscription, only: :create
  before_action :check_customer_subscription, only: :update

  def create
    customer_subscription = CustomerSubscription.new(customer_subscription_params)
    customer_subscription.save!
    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: :created
  end

  def update
    customer_subscription = CustomerSubscription.find_by!(customer_id: params[:customer_id], subscription_id: params[:id])
    customer_subscription.update!(customer_subscription_params)
    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: :ok
  end

  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id, :status)
  end

  def check_customer_subscription
    Customer.find(params[:customer_id])
    Subscription.find(params[:id])
  end

  def check_subscription
    subscription = Subscription.find(params[:subscription_id])
    raise ActiveRecord::RecordInvalid.new if subscription.status == "inactive"
  end
end
