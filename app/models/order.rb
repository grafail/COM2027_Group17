class Order < ApplicationRecord
  belongs_to :user
  has_many :purchase, dependent: :destroy
  validates :user, :PriceTotal, presence: true

  validates :PriceTotal, numericality: { greater_than_or_equal_to: 0 }
end
