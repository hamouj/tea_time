class DeleteTeaSubscriptionIdReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :teas, :tea_subscription, index: true, foreign_key: true
    remove_reference :subscriptions, :tea_subscription, index: true, foreign_key: true
  end
end
