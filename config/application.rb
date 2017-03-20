require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bitbond
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.template_engine :slim
    end

    config.autoload_paths << Rails.root.join('lib')

    config.square_connect_host = 'https://connect.squareup.com'
    config.square_app_secret = 'sq0csp-ZincDPNaL0OEqHO8x4zj3k8ngKVlCHvgHUOjbzB1fuc'
    config.square_app_id = 'sq0idp-Kl2FODMBB-J6oUd3mBZOaw'
  end
end
