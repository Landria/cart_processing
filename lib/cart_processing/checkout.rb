# frozen_string_literal: true

require 'cart_processing/product'

module CartProcessing
  class Checkout
    attr_accessor :cart, :pricing_policies, :errors

    def initialize(*pricing_policies)
      @pricing_policies = pricing_policies.flatten
      @cart = {}
      @errors = []
    end

    def scan(product_code)
      if product = cart[product_code]
        product.quantity += 1
      else
        product = apply_pricing_policy(Product.find_by(:code, product_code))
      end

      cart[product_code] = product if product
    end

    def total
      total = cart.values.reduce(0) { |sum, product| sum + product.sub_total }
      to_money(total)
    end

    private

    def to_money(value)
      format('%.2f', value) + '€'
    end

    def apply_pricing_policy(product)
      return unless product

      pricing_policies.each do |pricing_policy|
        product.apply_pricing(pricing_policy) if pricing_policy.product_code == product.code
      end

      product
    end
  end
end
