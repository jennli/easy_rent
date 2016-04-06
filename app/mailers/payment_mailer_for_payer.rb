class PaymentMailerForPayer < ApplicationMailer
  default from: 'reservation@easyrent.com'

  def notify_payer(reservation)
    @reservation = reservation
    @listing = reservation.listing
    @payer = @reservation.user
    @url  = "http://localhost:3000/listings/#{@listing.id}/reservations/#{@reservation.id}"

    mail(to: @payer.email, subject: 'Reservation confirmation from Easy Rent')
  end
end
