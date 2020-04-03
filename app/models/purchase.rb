class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  validates :user, :ticket, :PriceTotal, presence: true
  validates_uniqueness_of :user_id, scope: :ticket_id
end
