class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  validates :user, :name, :location, presence: true

  geocoded_by :location
  after_validation :geocode, if: ->(obj){ obj.location.present? and obj.location_changed? }
end
