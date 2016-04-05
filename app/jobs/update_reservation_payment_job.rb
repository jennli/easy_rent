class UpdateReservationPaymentJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    reservation = args[0]
    paid_amount = reservation.total_paid
    expected_paid = reservation.total_price
    if paid_amount >= expected_paid
      reservation.pay!
    end
  end
end
