class Ticket < ApplicationRecord
  belongs_to :event
  validates :event, :price, :name, presence: true
end
