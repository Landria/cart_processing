# frozen_string_literal: true

module CartProcessing
  class Pricing
    attr_accessor :product_code, :price, :trigger_quantity, :discount_price

    def initialize(*args)
      @product_code, @price = args
    end

    def sub_total(quantity)
      price.to_f * quantity
    end
  end
end
