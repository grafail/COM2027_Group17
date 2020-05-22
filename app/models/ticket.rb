class Ticket < ApplicationRecord
  belongs_to :event
  has_many :purchase, dependent: :destroy
  validates :event, :quantity, :price, :name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
