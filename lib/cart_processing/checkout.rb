# frozen_string_literal: true

# Cart processing (checkout)
module CartProcessing
  #Checkout process
  class Checkout
    attr_accessor :cart, :pricing_rules, :errors

    def initialize(pricing_rules = nil)
      @pricing_rules = pricing_rules
      @cart = []
      @errors = []
    end

    def scan(product_name)
      product = Product.find_by(:code, product_name)

      if product
        cart << product
      else
        errors << { not_found: product_name }
      end
    end

    def total
      total = cart.inject(0) { |sum, product| sum + product.fetch(:price, 0).to_f }
      to_money(total)
    end

    private

    def to_money(value)
      format('%.2f', value) + '€'
    end
  end
end
