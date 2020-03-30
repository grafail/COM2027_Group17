json.extract! purchase, :id, :user_id, :ticket_id, :comments, :PriceTotal, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
