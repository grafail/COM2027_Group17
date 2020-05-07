class Purchase < ApplicationRecord
  belongs_to :ticket
  belongs_to :order
  validates :ticket, :order, presence: true
end
