class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]

  before_action :find_listing, except: [:index, :new, :create, :subregion_options]

  def index
    @listings = Listing.order("id DESC")
    respond_to do |format|
      format.html {render}
      format.json {render json: @listings.to_json}
    end
  end

  def new
    @listing = Listing.new
  end

  def create
    # byebug
    @listing = Listing.new listing_params
    @listing.user = current_user

    if @listing.save
      redirect_to @listing, notice:"listing created successfully"
    else
      flash[:alert] = "listing failed"
      render :new
    end
  end
  def show
    @reservation = Reservation.new
  end

  def edit
    # byebug
  end

  def update
    if @listing.update listing_params
      redirect_to @listing, notice:"updated successfully"
    else
      redirect_to @listing, alert:"can't update"
    end
  end

  def destroy
    @listing.destroy
    redirect_to root_path, notice:"successfully destroy listing '#{@listing.title}'"
  end

  def reserved_dates
    respond_to do |format|
      format.html {redirect_to root_path, alert:"access denied"}
      format.json {render json: @listing.reserved_dates.to_json}
    end
  end

  def subregion_options
    render partial: 'subregion_select'
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :pic_1, :description, :daily_rate, :monthly_rate, :address, :city, :province, :country)
  end


  def find_listing
    @listing = Listing.find params[:id]
  end

end
