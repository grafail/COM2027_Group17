class Ticket < ApplicationRecord
  belongs_to :event
  has_one :purchase, dependent: :destroy
  validates :event, :price, :name, presence: true
end
