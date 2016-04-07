class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :reservations, dependent: :nullify

  mount_uploader :pic_1, ImageUploader

  geocoded_by :full_street_address   # can also be an IP address

  validates :title, presence:true, uniqueness:true
  validates :pic_1, presence: :true
  validates :address, presence: :true
  validates :city, presence: :true
  validates :province, presence: :true
  validates :country, presence: :true
  validates :daily_rate, presence: true, unless: :monthly_rate?

  after_validation :geocode          # auto-fetch coordinates

  def full_street_address
    "#{address} #{city} #{province} #{country}"
  end

  # Return the unavailable days of the listing in an array
  def reserved_dates
    days = reservations.all.map do |x|
      if x.aasm_state != "canceled"
        (x.checkin_date...x.checkout_date).map{|d| d}
      end
    end
    days.compact.flatten
  end
end
