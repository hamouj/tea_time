class UpdateAssociationBetweenTeaAndSubscription < ActiveRecord::Migration[7.0]
  def change
    add_reference :subscriptions, :tea_subscription, index: true
    add_foreign_key :subscriptions, :tea_subscriptions

    add_reference :teas, :tea_subscription, index: true
    add_foreign_key :teas, :tea_subscriptions

    remove_reference :subscriptions, :tea, index: true, foreign_key: true
  end
end
