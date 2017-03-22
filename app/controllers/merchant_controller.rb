class MerchantController < ApplicationController
  def callback
    authorization = SquareAuthorization.authorize!(params['code'])

    if authorization.has_key?(:error)
      render plain: authorization[:error]
    else
      sandbox_access_token = Rails.application.config.sandbox_square_app_secret
      access_token = Rails.env.test? ? authorization[:access_token] : sandbox_access_token

      merchant = Merchant.find_or_create_by(access_token: access_token)
      merchant.fetch_merchant_locations
      render plain: "Access Token: #{access_token}"
    end
  end
end
