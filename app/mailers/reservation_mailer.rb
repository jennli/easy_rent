class ReservationMailer < ApplicationMailer
  default from: 'reservation@easyrent.com'

  def notify_listing(reservation)
    @reservation = reservation
    @listing = reservation.listing
    @owner = @listing.user

    @url  = "http://localhost:3000/listings/#{@listing.id}/reservations/#{@reservation.id}"
    mail(to: @owner.email, subject: 'someone reserved your listing')
  end
end
