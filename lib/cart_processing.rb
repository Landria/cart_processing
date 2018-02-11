# frozen_string_literal: true

require 'cart_processing/configuration'
require 'errors/configuration'
require 'errors/invalid_source'
require 'errors/product_not_found'
require 'errors/unavailable_source_type'

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
require 'cart_processing/two_for_one_pricing'
require 'cart_processing/x_more_pricing'
