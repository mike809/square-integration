class Admin::MerchantLocationsController < ApplicationController
  def show
    @merchant_location = MerchantLocation.find_by_id(params[:id])
  end
end
