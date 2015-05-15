require 'omniauth'

module OmniAuth
  module ProviderRegistry
    class RailsMiddlewareSource
      def self.providers
        new(Rails.application.config.middleware).providers
      end

      def initialize(middlewares)
        @middlewares = middlewares
      end

      def providers
        builders = @middlewares.select{|m| m === OmniAuth::Builder }.flat_map{|b|
          b.build(nil).instance_variable_get(:@use)
        }
        direct = @middlewares.select{|m| m.klass.is_a?(Class) && m.klass <= OmniAuth::Strategy}.map{|s|
          ->{ s.build(nil) }
        }
        builders + direct
      end
    end
  end
end
