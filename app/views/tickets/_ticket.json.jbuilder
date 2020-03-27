json.extract! ticket, :id, :EventID, :Price, :Name, :Description, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
