json.extract! purchase, :id, :TicketID, :Comments, :PriceTotal, :PurchaserID, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
