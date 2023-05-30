require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it {should have_many :customer_subscriptions}
    it {should belong_to :tea}
  end
end
