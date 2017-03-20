class MerchantController < ApplicationController
  def callback
    authorization = SquareAuthorization.authorize!(params['code'])

    if authorization.has_key?(:error)
      render plain: authorization[:error]
    else
      access_token = authorization[:access_token]
      render plain: 'Success!'
      Merchant.create(access_token: access_token)
    end
  end
end
