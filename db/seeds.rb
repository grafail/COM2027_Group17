# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
User.create([email:'1', encrypted_password:'', description:'', location:''])

Event.create([user_id:'1', name:'', description:'', location:''])

Ticket.create([event_id:'1', price:'', name:'', description:''])

Purchase.create([user_id:'1', ticket_id:'1', comments:'', PriceTotal:''])
