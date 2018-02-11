# frozen_string_literal: true

module CartProcessing
  class Configuration < StandardError
    attr_accessor :source_path

    AVAILABLE_SOURCE_TYPES = %i[text sql].freeze
    DEFAULT_SOURCE = :text

    def initialize
      @source = nil
      @source_path = nil
    end

    def source_class_name
      "CartProcessing::#{source.to_s.split('_').map(&:capitalize!).join('')}Source" unless source.nil?
    end

    def source
      @source || DEFAULT_SOURCE
    end

    def source_file_name
      "#{source}_source" unless source.nil?
    end

    def source=(source_type)
      @source = source_type if AVAILABLE_SOURCE_TYPES.include?(source_type)
      @source ||= DEFAULT_SOURCE
    end
  end
end
