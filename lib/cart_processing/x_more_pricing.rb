# frozen_string_literal: true

require 'cart_processing/pricing'

module CartProcessing
  class XMorePricing < Pricing
    attr_accessor :trigger_quantity, :discount_price

    def initialize(*args)
      @product_code, @trigger_quantity, @discount_price, @price = args
    end

    def sub_total(quantity)
      @price = discount_price if quantity >= trigger_quantity
      super quantity
    end
  end
end
