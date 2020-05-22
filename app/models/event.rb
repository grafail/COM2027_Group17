class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  enum eventType: %i[Music Sports Religious Charitable Hobby Misc.]
  validates :user, :name, :location, :eventType, :eventDate, presence: true
  validate :date_cannot_be_in_the_past
  validate :must_be_business_account

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
      start_date = start_date.to_datetime
      end_date = end_date.to_datetime.at_end_of_day
      where('eventDate >= ? AND eventDate <= ?', start_date, end_date)
    elsif start_date.present?
      start_date = start_date.to_datetime
      where('eventDate >= ?', start_date)
    elsif end_date.present?
    end_date = end_date.to_datetime.at_end_of_day
    where('eventDate <= ?', end_date)
    else
      all
    end
  end

  def date_cannot_be_in_the_past
    if self.eventDate.present? && self.eventDate < Date.today
      errors.add(:eventDate, " can't be in the past")
    end
  end

  def must_be_business_account
    @user = User.find_by(id:self.user)
    if @user.nil? || !@user.isBusiness?
      errors.add(:user, " must be a business")
    end
  end



end
