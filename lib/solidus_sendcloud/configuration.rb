# frozen_string_literal: true

module SolidusSendcloud
  class Configuration
    # Define here the settings for this extension, e.g.:
    
    attr_accessor :public_key, :secret_key
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end
