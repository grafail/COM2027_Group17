User.create!([
               { email: "test@example.org", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, isBusiness:false},
               { email: "test2@example.org", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, isBusiness:true }
             ])
Event.create!([
                { user_id: 2, name: "Test Event 1", description: "This is a description.", eventDate: "2020-12-25 18:00:00", location: "Guildford", latitude: 51.2356068, longitude: -0.5732063, eventType: 1 },
                { user_id: 2, name: "Test Event 2", description: "This is a description.", eventDate: "2020-12-26 18:00:00", location: "New York", latitude: 40.7127281, longitude: -74.0060152, eventType: 1 },
                { user_id: 2, name: "Test Event 3", description: "This is a description.", eventDate: "2020-12-27 18:00:00", location: "New York", latitude: 40.7127281, longitude: -74.0060152, eventType: 0 }
              ])
Ticket.create!([
                 { event_id: 1, price: 50.0, name: "Ticket 1", description: "Test description", quantity: 20 },
                 { event_id: 1, price: 150.0, name: "Ticket 2", description: "Test description", quantity: 30 },
                 { event_id: 2, price: 20.0, name: "Ticket 3", description: "Test description", quantity: 40 },
                 { event_id: 2, price: 80.0, name: "Ticket 4", description: "Test description", quantity: 50 },
                 { event_id: 3, price: 1000.0, name: "Ticket 5", description: "Test description", quantity: 60 }
               ])
Order.create!([
                { user_id: 1, comments: "", PriceTotal: 10.0 },
                { user_id: 1, comments: "This is a test comment.", PriceTotal: 1.0 }
              ])
Purchase.create!([
                   { ticket_id: 1, order_id: 1, qty: 3 },
                   { ticket_id: 1, order_id: 2, qty: 2 },
                   { ticket_id: 2, order_id: 2, qty: 10 }
                 ])
