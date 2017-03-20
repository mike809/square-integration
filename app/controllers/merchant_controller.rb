class MerchantController < ApplicationController
  def callback
    authorization = SquareAuthorization.authorize!(params['code'])

    if authorization.has_key?(:error)
      render plain: authorization[:error]
    else
      access_token = authorization[:access_token]
      merchant = Merchant.find_or_create_by(access_token: access_token)
      merchant.fetch_merchant_locations
      render plain: 'Success!'
    end
  end
end
