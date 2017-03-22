require 'unirest'

class SquareAuthorization
  OAUTH_REQUEST_HEADERS = {
    'Authorization' => "Client #{Rails.application.config.square_app_secret}",
    'Accept' => 'application/json',
    'Content-Type' => 'application/json'
  }

  def self.authorize!(authorization_code)
    if authorization_code
      oauth_request_body = {
        'client_id' => Rails.application.config.square_app_id,
        'client_secret' => Rails.application.config.square_app_secret,
        'code' => authorization_code
      }

      response = Unirest.post "#{Rails.application.config.square_connect_host}/oauth2/token",
                              headers: OAUTH_REQUEST_HEADERS,
                              parameters: oauth_request_body

      if response.body.key?('access_token')
        { access_token: response.body['access_token'] }
      else
        { error: 'Code exchange failed!' }
      end
    else
      { error: 'Authorization failed!' }
    end
  end
end