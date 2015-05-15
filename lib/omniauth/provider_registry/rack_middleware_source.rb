module OmniAuth
  module ProviderRegistry
    class RackMiddlewareSource
      def self.providers
        raise "Support for non-Rails applications has not been implemented yet"
      end
    end
  end
end
