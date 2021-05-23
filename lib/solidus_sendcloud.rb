# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

require 'solidus_sendcloud/configuration'
require 'solidus_sendcloud/version'
require 'solidus_sendcloud/engine'

module SolidusSendcloud
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
