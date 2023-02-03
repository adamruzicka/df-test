require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
require 'sequel'
Bundler.require(*Rails.groups)

module DfTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    #
    config.eager_load_paths << Rails.root.join("app/lib")
    # Use Dynflow as the backend for ActiveJob
    config.active_job.queue_adapter = :dynflow

    config.after_initialize do
      init_dynflow
    end

    def dynflow
      @dynflow ||= ::Dynflow::Rails.new.tap(&:require!)
    end

    def init_dynflow
      dynflow.eager_load_actions!
    end
  end
end
