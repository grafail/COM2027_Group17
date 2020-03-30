class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  validates :user, :name, :location, presence: true
  validates :user, uniqueness: true
end
