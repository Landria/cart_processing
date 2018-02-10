# frozen_string_literal: true

module CartProcessing
  module BaseSource
    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

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

    module InstanceMethods; end
  end
end
