# frozen_string_literal: true

require 'cart_processing/base_source'
require 'csv'
require 'ostruct'

module CartProcessing
  class TextSource
    include BaseSource

    def initialize
      raise 'Cant be instantiated!'
    end

    class << self
      def find_by(attr, value)
        CSV.foreach(connection, headers: true, header_converters: :symbol, converters: :all) do |row|
          data = Hash[row.to_a]
          return new(object_wrapper(data)) if data.fetch(attr.to_sym) == value
        end
      rescue Errno::ENOENT, NoMethodError
        raise Errors::InvalidSource, 'Text source is invalid'
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
      rescue Errno::ENOENT, NoMethodError
        raise Errors::InvalidSource, 'Text source is invalid'
      end

      def object_wrapper(data)
        OpenStruct.new(data)
      end
    end
  end
end
