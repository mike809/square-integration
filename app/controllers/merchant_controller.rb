class MerchantController < ApplicationController

  def new
  end

  def callback
    authorization = SquareAuthorization.authorize!(params['code'])

    if authorization.has_key?(:error)
      render plain: authorization[:error] # TODO: Error or something
    else
      access_token = authorization[:access_token]
      render plain: 'Success!'
      # TODO: Store access_token securely
      Merchant.create(access_token: access_token)
      # and use it in subsequent requests to the Connect API on behalf of the merchant.
    end
  end
end
