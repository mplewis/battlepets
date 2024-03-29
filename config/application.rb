require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Battlepets
  class Application < Rails::Application
    # API-only project - no views, etc
    config.api_only = true
    # Enable better logging
    config.lograge.enabled = true

    # Use Delayed Job to run async tasks
    config.active_job.queue_adapter = :delayed_job

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
