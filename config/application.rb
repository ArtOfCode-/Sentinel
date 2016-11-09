require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sentinel
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/api/*', :headers => :any, :methods => [:get]
        # resource '/api/w/*', :headers => :any, :methods => [:post], :credentials => true
        # resource '/oauth/token', :headers => :any, :methods => [:get]
      end
    end
  end
end
