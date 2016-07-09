source 'https://rubygems.org'

# Set a fixed Ruby version for Heroku
ruby '2.3.1'

# Core Rails stuff

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use Passenger as the Rails server
gem 'passenger'
# Use PostgreSQL as the database for Active Record
gem 'pg'

# Backend

# JSONAPI builds awesome standardized JSON objects for API usage
gem 'jsonapi-resources'
# Delayed Job lets us run long-running processes separately from the main Rails app
gem 'delayed_job_active_record'

# Utilities

# Less verbose logging
gem 'lograge'
# Better error pages when stuff breaks
gem 'better_errors'
# Random data for tests and seeds
gem 'faker'
# Factory creation instead of fixtures for test data
gem 'factory_girl_rails'
# Live debugging in web REPL
gem 'binding_of_caller'
# Better `rails c`
gem 'pry'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Open emails in the browser
  gem 'letter_opener'
end

group :production do
  # Heroku + Rails support
  gem 'rails_12factor'
  # Email using Railgun
  gem 'mailgun_rails'
end

