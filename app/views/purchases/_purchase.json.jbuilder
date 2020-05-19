json.extract! purchase, :id, :ticket_id, :order_id, :qty, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
