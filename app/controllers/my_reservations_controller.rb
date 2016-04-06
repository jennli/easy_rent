class MyReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_reservations = current_user.reservations.order("created_at DESC")
  end

end
