require 'minitest/autorun'
require 'omniauth/provider_registry/registry'

describe OmniAuth::ProviderRegistry::Registry do
  describe "when asked to find a provider it doesn't know about" do
    it "returns nil" do
      registry = OmniAuth::ProviderRegistry::Registry.new([])
      registry.find(:unknown_provider).must_be_nil
    end
  end

  describe "when asked to find a provider it does know about" do
    def provider_factories
      @provider_factories ||= [
        -> { OpenStruct.new(name: "red") },
        -> { OpenStruct.new(name: "orange") },
        -> { OpenStruct.new(name: "yellow") },
      ]
    end

    it "returns an instance of a configured strategy" do
      registry = OmniAuth::ProviderRegistry::Registry.new(provider_factories)
      provider = registry.find("orange")

      provider.wont_be_nil
      provider.name.to_s.must_equal "orange"
    end

    it "finds instances by symbol name" do
      registry = OmniAuth::ProviderRegistry::Registry.new(provider_factories)
      provider = registry.find(:orange)
      provider.wont_be_nil
    end
  end
end
