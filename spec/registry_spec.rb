require 'minitest/autorun'
require 'omniauth/provider_registry/registry'

describe OmniAuth::ProviderRegistry::Registry do
  describe "when asked to find a provider it doesn't know about" do
    it "returns nil" do
      registry = OmniAuth::ProviderRegistry::Registry.new([])
      registry.find(:unknown_provider).must_be_nil
    end
  end
end
