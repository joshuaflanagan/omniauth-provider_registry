require 'minitest/autorun'
require 'omniauth/provider_registry'

describe OmniAuth::ProviderRegistry do
  describe "determining the source of providers" do
    it "uses RailsMiddlewareSource in Rails application" do
      Rails = OpenStruct.new(application: Object.new)

      source = OmniAuth::ProviderRegistry.source

      source.must_equal OmniAuth::ProviderRegistry::RailsMiddlewareSource
    end

    it "uses RackMiddlewareSource when not in Rails application" do
      source = OmniAuth::ProviderRegistry.source

      source.must_equal OmniAuth::ProviderRegistry::RackMiddlewareSource
    end

    before do
      @original_rails_const = Object.__send__(:remove_const, :Rails) if defined?(Rails)
    end

    after do
      Object.__send__(:remove_const, :Rails) if defined?(Rails)
      Object.__send__(:const_set, "Rails", @original_rails_const) if @original_rails_const
    end
  end

end
