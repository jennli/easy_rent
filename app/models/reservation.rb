class Reservation < ActiveRecord::Base
  require 'digest/sha1'
  require 'digest/md5'
  belongs_to :user
  belongs_to :listing

  validates :checkin_date, presence: :true
  validates :checkout_date, presence: :true
  validate :checkout_date_is_after_checkin_date
  validate :dates_are_in_the_future, on: :create

  validate :dates_are_avaialble, on: :create

  include AASM
  # setting the whiny_transitions: false option makes it so that it won't
  # throw an exception when an invalid transition happen
  aasm whiny_transitions: false do
    state :unpaid, initial: true
    state :paid
    state :completed
    state :canceled

    event :pay do
      transitions from: :unpaid, to: :paid
    end

    event :cancel do
      transitions from: [:unpaid], to: :canceled
    end

    event :complete do
      transitions from: [:paid], to: :completed
    end

  end

  def paid
    where(aasm_state: :paid)
  end

  def reserved_nights
    (checkout_date - checkin_date).to_i
  end

  def checkout_date_is_after_checkin_date
    if (checkout_date - checkin_date).to_i <= 0
      errors.add(:checkout_date, "must be later than check in date!")
    end
  end

  def dates_are_avaialble
    reservations = listing.reservations.order(:id)
    if reservations.size > 1
      i = 0
      while i < reservations.size
        r = reservations[i]
        if r.aasm_state != "canceled"
          a = (checkin_date - r.checkout_date).to_i
          x = (r.checkin_date - checkout_date).to_i
          if a * x > 0
            errors.add(:checkout_date, "or checkin date not available")
            break
          end
        end
        i += 1
      end
    end
  end

  def dates_are_in_the_future
    if checkin_date <= Date.new
      errors.add(:checkin_date, "is in the past..")
    elsif checkout_date <= Date.new
      errors.add(:checkout_date, "is in the past..")
    end
  end

  def displayed_id
    "#{listing.title.split("")[0]}#{listing.id}-#{id}-#{user.id}"
  end

end
