class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :user, :ticket, :PriceTotal, presence: true
  validates :user, :ticket, uniqueness: true
end
