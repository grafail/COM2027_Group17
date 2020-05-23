json.extract! order, :id, :user_id, :comments, :PriceTotal, :created_at, :updated_at
json.url order_url(order, format: :json)
