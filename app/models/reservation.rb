class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :checkin_date, presence: :true
  validates :checkout_date, presence: :true
  validate :checkout_date_is_after_checkin_date

  validate :dates_are_avaialble


  def checkout_date_is_after_checkin_date
    if (checkout_date - checkin_date).to_i <= 0
      errors.add(:checkout_date, "must be later than check in date!")
    end
  end

  def dates_are_avaialble
    if listing.reservations.size > 1
      listing.reservations.each do |r|
        a = (checkin_date - r.checkout_date).to_i
        x = (r.checkin_date - checkout_date).to_i
        if a * x > 0
          if (checkin_date - r.checkin_date).to_i > 0
            errors.add(:checkin_date, "checkin date is not available")
          else
            errors.add(:checkout_date, "checkout date is not available")
          end
          break
        end
      end
    end
  end

end
