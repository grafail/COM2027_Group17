class Ticket < ApplicationRecord
  belongs_to :event
  has_many :purchase, dependent: :destroy
  validates :purchase, :event, :price, :name, presence: true
end
