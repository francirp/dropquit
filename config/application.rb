require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Dropquit
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"

      config.to_prepare do
        Devise::SessionsController.layout "registrations"
        Devise::PasswordsController.layout "registrations"
      end

      config.paperclip_defaults = {
      :default_url => "default_avatar.png",
      :storage => :s3,
      :s3_credentials => {
        :bucket => ENV['AWS_BUCKET'],
        :access_key_id => ENV['AWS_ACCESS_KEY'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
        }
      }

      config.action_mailer.delivery_method = :smtp
      config.action_mailer.default_url_options = { :host => ENV['APPLICATION_ROOT_URL'] }
      config.action_mailer.perform_deliveries = true

      config.action_mailer.smtp_settings = {
        address: "smtp.mandrillapp.com",
        port: 587,
        domain: ENV['APPLICATION_ROOT_URL'],
        authentication: "plain",
        enable_starttls_auto: true,
        user_name: ENV['EMAIL'],
        password: ENV['EMAIL_PASSWORD']
      }
    end
  end
end
