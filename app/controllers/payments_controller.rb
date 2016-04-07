class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_reservation

  def new
  end

  def create
    service = Payments::HandlePayment.new(user: current_user, stripe_token: params[:stripe_token], reservation: @reservation)
    if service.call
      UpdateReservationPaymentJob.perform_now(@reservation)
      PaymentMailerForPayer.notify_payer(@reservation).deliver_now
      redirect_to listing_reservation_path(@reservation.listing, @reservation), notice: "Payment completed! A confirmation email was sent to #{@reservation.user.email}"
    else
      flash[:alert] = "#{@reservation.errors.full_messages.join(",")} error"
      render :new
    end
  end

  private

  def find_reservation
    @reservation = Reservation.find params[:reservation_id]
  end
end
