# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
User.create([email: "testadmin@hotmail.co.uk", password: "testadminuser", password_confirmation: "testadminuser"])

Event.create([user_id:'1', name:'Event1', description:'Description of Event1', location:'100 Weston Road, GU2 8AW'])

Ticket.create([event_id:'1', price:'100', name:'Ticket1', description:'Description of Ticket1'])

Purchase.create([user_id:'1', ticket_id:'1', comments:'comments about the purchase', PriceTotal:'100'])
