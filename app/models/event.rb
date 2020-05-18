class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  enum eventType: %i[Music Sports Religious Charitable Hobby Misc.]
  validates :user, :name, :location, :eventType, presence: true

  geocoded_by :location
  after_validation :geocode, if: ->(obj) { obj.location.present? && obj.location_changed? }

  def self.in_category(category)
    if category.present?
      category=Event.eventTypes[category]
      where('eventType = ?', category)
    else
      all
    end
  end


  def self.in_dates(start_date, end_date)
    if start_date.present? and end_date.present?
      where('date >= ? AND date <= ?', start_date, end_date)
    elsif start_date.present?
      where('date = ?', start_date)
    else
      all
    end
  end

end
