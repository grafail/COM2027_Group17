class Purchase < ApplicationRecord
  belongs_to :ticket
  belongs_to :order
  validates :ticket, :order, :qty, presence: true

  validates :qty, numericality: { greater_than_or_equal_to: 0 }

end
