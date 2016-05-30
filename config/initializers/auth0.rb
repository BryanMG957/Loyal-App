Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'BoaqBRsZcUMQWfcLYQb6xsrKedImSVoq',
    'orEV70LcbNmV9Kuo4TgUI_LD1BO5lVpU3l_6LSu8ZA-xB4ivLmP9dc3DbuMeZKv9',
    'app51444444.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end
