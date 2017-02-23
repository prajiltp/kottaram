Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_app['client_id'], Rails.application.secrets.google_app['client_secret']
end