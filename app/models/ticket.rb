class Ticket < ApplicationRecord
  belongs_to :event
  has_many :purchase, dependent: :destroy
  validates :event, :price, :name, presence: true
end
