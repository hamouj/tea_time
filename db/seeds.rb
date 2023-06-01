Customer.destroy_all
Subscription.destroy_all
Tea.destroy_all

customer1 = Customer.create!({ first_name: "Jasmine", last_name: "Hamou", email: "j@gmail.com", address: "123 Neverland Ave, Las Vegas, NV 12345"})
customer2 = Customer.create!({ first_name: "Hailey", last_name: "Harper", email: "h@gmail.com", address: "456 Imaginary St, Las Vegas, NV 45678"})
customer3 = Customer.create!({ first_name: "Ivan", last_name: "Andrew", email: "i@gmail.com", address: "789 North Ave, Las Vegas, NV 78910"})

tea1 = Tea.create!({ title: "Earl Grey", description: "tastes like morning", temperature: 208, brew_time: 4 })
tea2 = Tea.create!({ title: "Peppermint", description: "tastes minty", temperature: 200, brew_time: 3 })
tea3 = Tea.create!({ title: "Green Tea", description: "tastes like the energizer bunny", temperature: 180, brew_time: 4 })

subscription1 = Subscription.create!({ title: "Get Your Tea On", price: 5500, status: 0, frequency: 1 })
subscription2 = Subscription.create!({ title: "Tea Yeah", price: 6230, status: 0, frequency: 2 })
subscription3 = Subscription.create!({ title: "Pepperminty", price: 2310, status: 0, frequency: 3 })
subscription4 = Subscription.create!({ title: "I'm Feeling Green", price: 1250, status: 0, frequency: 2 })
subscription5 = Subscription.create!({ title: "Tea Much?", price: 4550, status: 1, frequency: 1 })

CustomerSubscription.create!({ customer: customer1, subscription: subscription1, status: 0 })
CustomerSubscription.create!({ customer: customer1, subscription: subscription5, status: 0 })
CustomerSubscription.create!({ customer: customer2, subscription: subscription2, status: 1 })
CustomerSubscription.create!({ customer: customer2, subscription: subscription3, status: 0 })
CustomerSubscription.create!({ customer: customer3, subscription: subscription4, status: 0 })

TeaSubscription.create!({ tea: tea1, subscription: subscription1 })
TeaSubscription.create!({ tea: tea3, subscription: subscription1 })

TeaSubscription.create!({ tea: tea1, subscription: subscription2 })
TeaSubscription.create!({ tea: tea2, subscription: subscription2 })
TeaSubscription.create!({ tea: tea3, subscription: subscription2 })

TeaSubscription.create!({ tea: tea2, subscription: subscription3 })

TeaSubscription.create!({ tea: tea3, subscription: subscription4 })

TeaSubscription.create!({ tea: tea2, subscription: subscription5 })
TeaSubscription.create!({ tea: tea3, subscription: subscription5 })
