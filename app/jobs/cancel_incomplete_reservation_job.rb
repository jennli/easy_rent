class CancelIncompleteReservationJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    reservation = args[0]
    if reservation.aasm_state == "unpaid"
      reservation.cancel!
    end
  end
end
