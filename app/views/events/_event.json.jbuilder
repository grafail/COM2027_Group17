json.extract! event, :id, :SellerID, :Name, :Address, :Twitter, :IsBusiness, :created_at, :updated_at
json.url event_url(event, format: :json)
