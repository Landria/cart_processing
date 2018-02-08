# frozen_string_literal: true

require 'cart_processing/base_source'
require 'csv'

module CartProcessing
  # Handling CSV data
  class TextSource
    include BaseSource

    class << self
      def find_by(attr, value)
        CSV.foreach(connection, headers: true, header_converters: :symbol, converters: :all) do |row|
          data = row.to_a.to_h
          return data if data.fetch(attr.to_sym) == value
        end
      end

      def all
        csv_data
      end

      private

      def csv_data
        data = []

        CSV.foreach(connection, headers: true, header_converters: :symbol, converters: :all) do |row|
          data << row.to_a.to_h
        end
        data
      rescue Errno::ENOENT => e
        puts e.inspect
        data
      end
    end
  end
end
