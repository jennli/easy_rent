class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_listing
  before_action :find_reservation, only: [:show, :edit, :update, :destroy]

  def show

  end

  def create
    @reservation = @listing.reservations.new reservation_params
    @reservation.total_price = @reservation.reserved_nights * @listing.daily_rate
    @reservation.user = current_user

    if @reservation.save
      
      redirect_to new_reservation_payment_path(@reservation), notice: "we have reserved this listing during the days you requested, you have 30 minutes to submit your payment!"
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

  def find_reservation
    @reservation = Reservation.find params[:id]
  end

end
