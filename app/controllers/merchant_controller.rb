class MerchantController < ApplicationController
  def callback
    authorization = SquareAuthorization.authorize!(params['code'])

    if authorization.has_key?(:error)
      render plain: authorization[:error]
    else
      access_token = 'sandbox-sq0atb-MKh5RyMa3ASgbDrR16gDXw' # authorization[:access_token]
      merchant = Merchant.find_or_create_by(access_token: access_token)
      merchant.fetch_merchant_locations
      render plain: "Access Token: #{access_token}"
    end
  end
end
