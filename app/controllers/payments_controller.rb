class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_reservation

  def new
  end

  def create
    service = Payments::HandlePayment.new(user: current_user, stripe_token: params[:stripe_token], reservation: @reservation)
    if service.call
      DetermineReservationPaymentStateJob.perform_now(@reservation)
      redirect_to listing_reservation_path(@reservation.listing, @reservation), notice: "Thanks for completing the payment"
    else
      flash[:alert] = "Error happened! Please try again."
      render :new
    end
  end

  private

  def find_reservation
    @reservation = Reservation.find params[:reservation_id]
  end
end
