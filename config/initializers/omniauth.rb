Rails.application.config.middleware.use OmniAuth::Builder do
  # omniauth github provider
  # @TODO: @q9f setup credentials
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end
