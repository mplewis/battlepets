source 'https://rubygems.org'

# Set a fixed Ruby version for Heroku
ruby '2.3.1'

# Core Rails stuff

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# This is an API-only project
gem 'rails-api'
# Use Passenger as the Rails server
gem 'passenger'
# Use PostgreSQL as the database for Active Record
gem 'pg'

# Backend

# Serialize resources into JSON
gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
# Delayed Job lets us run long-running processes separately from the main Rails app. Relies on daemons.
gem 'delayed_job_active_record'
gem 'daemons'

# Business logic

# Gaussian distributions for stat gains and contest performance
gem 'distribution'

# Utilities

# Less verbose logging
gem 'lograge'
# Random data for tests and seeds
gem 'faker'
# Factory creation instead of fixtures for test data
gem 'factory_girl_rails'
# Progress bar for seeds
gem 'ruby-progressbar'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Open emails in the browser
  gem 'letter_opener'
  # Better `rails c`
  gem 'pry-rails'
  # Better error pages when stuff breaks
  gem 'better_errors'
  # Live debugging in web REPL
  gem 'binding_of_caller'
end

group :assets do
  # Help Heroku precompile assets
  gem 'uglifier'
end

group :production do
  # Heroku + Rails support
  gem 'rails_12factor'
  # Email using Railgun
  gem 'mailgun_rails'
end

