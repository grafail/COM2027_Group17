class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  enum eventType: %i[Music Sports Religious Charitable Hobby Misc.]
  validates :user, :name, :location, :eventType, presence: true

  geocoded_by :location
  after_validation :geocode, if: ->(obj) { obj.location.present? && obj.location_changed? }

  def self.in_category(category)
    if category.present?
      where('eventType = ?', category)
    else
      all
    end
  end
end
