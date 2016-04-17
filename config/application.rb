require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dobermen
  class Application < Rails::Application
    
    # Set timezone
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # Set locale
    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # Set generator
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      g.test_framework  :rspec, fixture: true, dir: 'spec'
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs false
      g.controller_specs true
      g.routing_specs false
      g.helper_specs false
      g.request_specs false
      g.assets false
      g.helper false
    end

    # auto loading
    config.autoload_paths += %W(#{config.root}/app/models/types)
  end
end
