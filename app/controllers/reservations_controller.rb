class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_listing

  def create
    @reservation = Reservation.new reservation_params
    @reservation.listing = @listing
    @reservation.user = current_user
    # byebug
    if @reservation.save
      redirect_to @listing, notice: "you have successfully reserved this room!"
    else
      redirect_to @listing, alert:"#{@reservation.errors.full_messages.join(',')}"
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:checkin_date, :checkout_date, :rate_type)
  end

  def find_listing
    @listing = Listing.find params[:listing_id]
  end

end
