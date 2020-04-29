User.create!([
  {email: "test@example.org", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil}
])
Event.create!([
  {user_id: 1, name: "Test Event 1", description: "This is a description.", location: "Guildford", latitude: 51.2356068, longitude: -0.5732063},
  {user_id: 1, name: "Test Event 2", description: "This is a description.", location: "New York", latitude: 40.7127281, longitude: -74.0060152}
])
Ticket.create!([
  {event_id: 1, price: 1.0, name: "Ticket 1", description: "Test description"},
  {event_id: 1, price: 123.0, name: "Ticket 2", description: "Test description"}
])
Order.create!([
  {user_id: 1, comments: "", PriceTotal: 10.0, isComplete: nil},
  {user_id: 1, comments: "This is a test comment.", PriceTotal: 1.0, isComplete: nil}
])
Purchase.create!([
  {ticket_id: 1, order_id: 1, qty: 3},
  {ticket_id: 1, order_id: 2, qty: 2},
  {ticket_id: 2, order_id: 2, qty: 10}
])

