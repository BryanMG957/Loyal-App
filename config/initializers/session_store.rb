# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_Loyal_session'

# Fix CookieOverflow
Rails.application.config.session_store :cache_store

