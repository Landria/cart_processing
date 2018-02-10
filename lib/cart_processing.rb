# frozen_string_literal: true

require 'cart_processing/configuration'

module CartProcessing
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end

require 'cart_processing/version'
require 'cart_processing/checkout'
