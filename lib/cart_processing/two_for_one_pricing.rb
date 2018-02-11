# frozen_string_literal: true

require 'cart_processing/pricing'

module CartProcessing
  class TwoForOnePricing < Pricing
    def sub_total(quantity)
      payable_quantity = (quantity.even? ? quantity.to_i.div(2) : quantity.to_i.div(2) + 1)
      super payable_quantity
    end
  end
end
