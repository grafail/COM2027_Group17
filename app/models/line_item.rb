class LineItem < ApplicationRecord
  belongs_to :ticket
  belongs_to :cart
end
