# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

customer1 = Customer.create!({ first_name: "Jasmine", last_name: "Hamou", email: "j@gmail.com", address: "123 Neverland Ave, Las Vegas, NV 12345"})
customer2 = Customer.create!({ first_name: "Hailey", last_name: "Harper", email: "h@gmail.com", address: "456 Imaginary St, Las Vegas, NV 45678"})
customer3 = Customer.create!({ first_name: "Ivan", last_name: "Andrew", email: "i@gmail.com", address: "789 North Ave, Las Vegas, NV 78910"})

tea1 = Tea.create!({ title: "Earl Grey", description: "tastes like morning", temperature: 208, brew_time: 4 })
tea1 = Tea.create!({ title: "Peppermint", description: "tastes minty", temperature: 200, brew_time: 3 })
tea1 = Tea.create!({ title: "Green Tea", description: "tastes like the energizer bunny", temperature: 180, brew_time: 4 })

subscription1 = Subscription.create!({ title: "Get Your Tea On", price:  })
subscription2 = create(:subscription, tea_id:1 )
subscription3 = create(:subscription, tea_id:2 )
subscription4 = create(:subscription, tea_id:3 )
subscription5 = create(:cancelled_subscription, tea_id:3 )

create(:customer_subscription, customer: customer1, subscription: subscription1)
create(:customer_subscription, customer: customer1, subscription: subscription5)
create(:customer_subscription, customer: customer2, subscription: subscription2)
create(:customer_subscription, customer: customer2, subscription: subscription3)
create(:customer_subscription, customer: customer3, subscription: subscription4)
