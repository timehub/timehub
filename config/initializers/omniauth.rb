Rails.application.config.middleware.use OmniAuth::Builder do
  # Sign up at https://github.com/account/applications
  provider :github, APP_CONFIG[Rails.env]["github_id"], APP_CONFIG[Rails.env]["github_secret"], :scope => "repo"
end
