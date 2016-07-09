if Rails.env.production?
  Rails.application.config.secret_token = ENV['SECRET_TOKEN']
end