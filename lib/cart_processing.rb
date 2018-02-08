# frozen_string_literal: true

require 'cart_processing/version'
require 'cart_processing/configuration'
require 'cart_processing/text_source'
require 'cart_processing/sql_source'
require 'cart_processing/checkout'

# Handling Cart Processing
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

  class Product < Object.const_get("CartProcessing::#{configuration.source_class_name}Source"); end
end
