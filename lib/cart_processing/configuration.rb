# frozen_string_literal: true

module CartProcessing
  # Settings for checkout process
  class Configuration
    attr_accessor :source_path

    AVAILABLE_SOURCE_TYPES = %i[text sql].freeze
    DEFAULT_SOURCE = :text

    def initialize
      @source = nil
      @source_path = nil
    end

    def source_class_name
      source.to_s.split('_').map(&:capitalize!).join('')
    end

    def source
      @source || DEFAULT_SOURCE
    end

    def source=(source_type)
      @source = source_type if AVAILABLE_SOURCE_TYPES.include?(source_type)
      @source ||= DEFAULT_SOURCE
    end
  end
end
