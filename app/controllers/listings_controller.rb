class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]

  before_action :find_listing, except: [:index, :new, :create, :subregion_options]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
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
  end

  def edit
  end

  def update
    if @listing.update listing_params
      redirect_to @listing, notice:"updated successfully"
    else
      redirect_to @listing, alert:"can't update"
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
