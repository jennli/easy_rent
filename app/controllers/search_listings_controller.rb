class SearchListingsController < ApplicationController
  before_action :find_searchkey, only:[:show]
  def show
    @listings = Listing.where("city ilike ?", @key).order("id DESC")
    respond_to do |format|
      format.js {render :search_result}
    end
  end

  def find_searchkey
    @key = params[:id]
  end

end
