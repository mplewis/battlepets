class ApplicationController < ActionController::API
  # Don't worry about CSRF
  # Turn on Active Model Serializer
  include ::ActionController::Serialization
end
