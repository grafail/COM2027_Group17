class Order < ApplicationRecord
  belongs_to :user
  has_many :purchase, dependent: :destroy
  validates :user, :PriceTotal, presence: true
end
