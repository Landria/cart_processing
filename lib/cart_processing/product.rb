# frozen_string_literal: true

require "cart_processing/#{CartProcessing.configuration.source_file_name}"

module CartProcessing
  class Product < Object.const_get("CartProcessing::#{configuration.source_class_name}"); end
end
