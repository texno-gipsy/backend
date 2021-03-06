require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require 'sprockets/railtie'
require 'rails/test_unit/railtie'
require './config/initializers/modules.rb'

Bundler.require(*Rails.groups)

module TexnoGipsyBackend
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true
    config.time_zone = 'Europe/Moscow'
    config.active_record.schema_format = :sql
    config.application = config_for(:application)
  end
end
