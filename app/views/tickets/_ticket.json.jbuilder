json.extract! ticket, :id, :event_id, :price, :name, :description, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
