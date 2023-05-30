require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should have_many :customer_subscriptions }
    it { should belong_to :tea }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values(["active", "cancelled"])}
  end
end
