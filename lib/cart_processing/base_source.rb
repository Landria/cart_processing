# frozen_string_literal: true

module CartProcessing
  # Base module for data source
  module BaseSource
    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    # Class methods to be included
    module ClassMethods
      def connection
        CartProcessing.configuration.source_path
      end

      def find_by(*_)
        raise 'Not implemented'
      end

      def all
        raise 'Not implemented'
      end
    end

    # Instance methods to be included
    module InstanceMethods; end
  end
end
