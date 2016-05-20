Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'OZE54fxgtytTr1xQqdPyYtEkLA2QDZyc',
    '6IDYcGHZhcnA4BV3Y_D3GmU6BjtDEXwnOz6rsVszdSFOJiarWPnHeBhJCV2SRKF9',
    'bryanmg957.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end
