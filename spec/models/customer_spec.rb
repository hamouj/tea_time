require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :customer_subscriptions }
    it { should have_many(:subscriptions).through(:customer_subscriptions) }
  end

  describe "instance methods" do
    describe "#live_subscriptions" do
      it "returns all of a customer's subscriptions that are live" do
        customer = create(:customer)
        subscription1 = create(:subscription)
        subscription2 = create(:subscription)
        subscription3 = create(:inactive_subscription)

        create(:customer_subscription, customer:, subscription: subscription1)
        create(:customer_subscription, customer:, subscription: subscription2)
        create(:customer_subscription, customer:, subscription: subscription3)

        expect(customer.live_subscriptions).to match_array([subscription1, subscription2])

        subscription4 = create(:subscription)
        create(:customer_subscription, customer:, subscription: subscription4)

        expect(customer.live_subscriptions).to match_array([subscription1, subscription2, subscription4])
      end
    end
  end
end
