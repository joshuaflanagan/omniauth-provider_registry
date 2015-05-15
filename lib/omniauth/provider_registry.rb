require 'omniauth'
require "omniauth/provider_registry/version"
require "omniauth/provider_registry/registry"
require "omniauth/provider_registry/rack_middleware_source"
require "omniauth/provider_registry/rails_middleware_source"

module OmniAuth
  module ProviderRegistry
    def self.find(name)
      registry.find(name)
    end

    def self.registry
      @registry ||= Registry.new(source.providers)
    end

    def self.source
      if defined?(Rails)
        RailsMiddlewareSource
      else
        RackMiddlewareSource
      end
    end
  end
end
