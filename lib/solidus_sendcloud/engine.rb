# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'
# require 'solidus_webhooks'

module SolidusSendcloud
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_sendcloud'

    # initializer "solidus_sendcloud.webhooks" do
    #   SolidusWebhooks.config.register_webhook_handler :sendcloud, ->(payload) {
    #   }
    # end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
