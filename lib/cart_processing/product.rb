# frozen_string_literal: true

require "cart_processing/#{CartProcessing.configuration.source_file_name}"
require 'cart_processing/pricing'

module CartProcessing
  class Product < Object.const_get("CartProcessing::#{configuration.source_class_name}")
    attr_accessor :code, :name, :price, :pricing, :quantity

    def initialize(object)
      @code = object.code
      @name = object.name
      @price = object.price.to_f
      @quantity = 1
      apply_pricing(Pricing.new(@code, @price))
    end

    def apply_pricing(pricing_policy)
      pricing_policy.price ||= price
      @pricing = pricing_policy
    end

    def sub_total
      pricing.sub_total(quantity)
    end
  end
end
