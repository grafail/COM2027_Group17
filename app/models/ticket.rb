class Ticket < ApplicationRecord
  belongs_to :event
  has_many :purchase, dependent: :destroy
  has_many :line_items, dependent: :destroy
  validates :event, :price, :name, presence: true
end
