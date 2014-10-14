# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Seed admin for moderation
adminuser = User.create(name: "admin", email: "admin@admin.com", password: "foobar", password_confirmation: "foobar" )
adminuser.toggle!(:admin)

#Seed test users and offer / requests -> comment this for production
user1 = User.create(name: "Jan Kordaat", email: "test@gmail.com", password: "testtest", password_confirmation: "testtest" )
user1.toggle(:admin)
user2 = User.create(name: "Willem Willemson", email: "test@test.com", password: "testtest", password_confirmation: "testtest" )
user2.toggle(:admin)
user3 = User.create(name: "Hiro Satou", email: "test@test.test", password: "testtest", password_confirmation: "testtest" )
user2.toggle(:admin)

postOffer1 = Marketpost.create(title: "Offering Fish", message: "Fresh fish", user_id: 2, post_type: "offer")
postOffer2 = Marketpost.create(title: "Join my study group", message: "We study hard", user_id: 3, post_type: "offer")
postOffer3 = Marketpost.create(title: "Selling books Economics", message: "I have some economics books for sale. Message me", user_id: 4, post_type: "offer")
postRequest1 = Marketpost.create(title: "Looking for guidance", message: "Of the city", user_id: 2, post_type: "request")
postRequest2 = Marketpost.create(title: "In need for data tables", message: "Need data", user_id: 3, post_type: "request")
postRequest3 = Marketpost.create(title: "Requesting good food", message: "Cook mehhh", user_id: 4, post_type: "request")

message1 = Transaction.create(user_id: 3, sender_id: 2, receiver_id: 3, description: "hey I saw your Request. Can I join?", marketpost_id: 2)
message2 = Transaction.create(user_id: 2, sender_id: 2, receiver_id: 3, description: "Sure you can. We start on 15 february. What are your credentials?", marketpost_id: 2)
message3 = Transaction.create(user_id: 3, sender_id: 2, receiver_id: 3, description: "Yeah my number is ... I'm looking forward.", marketpost_id: 2)
message4 = Transaction.create(user_id: 2, sender_id: 2, receiver_id: 3, description: "Oh also, how many people joined?", marketpost_id: 2)
message5 = Transaction.create(user_id: 3, sender_id: 2, receiver_id: 3, description: "You're number 5. I'll add you to our Whatsapp", marketpost_id: 2)