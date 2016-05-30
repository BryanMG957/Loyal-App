Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Loyal App - configure server name:
  config.x.protocol = "http://"
  config.x.host = "localhost:3000"

  # Auth0 ID and domain
  # config.x.auth0_domain = 'bryanmg957.auth0.com'
  # config.x.auth0_client_ID = 'OZE54fxgtytTr1xQqdPyYtEkLA2QDZyc'
  # confix.x.auth0_client_secret = '6IDYcGHZhcnA4BV3Y_D3GmU6BjtDEXwnOz6rsVszdSFOJiarWPnHeBhJCV2SRKF9'
  config.x.auth0_domain = 'app51444444.auth0.com'
  config.x.auth0_client_ID = 'BoaqBRsZcUMQWfcLYQb6xsrKedImSVoq'
  config.x.auth0_client_secret = 'orEV70LcbNmV9Kuo4TgUI_LD1BO5lVpU3l_6LSu8ZA-xB4ivLmP9dc3DbuMeZKv9'
end
