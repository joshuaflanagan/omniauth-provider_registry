require 'minitest/autorun'
require 'omniauth/provider_registry/rails_middleware_source'
require 'action_dispatch/middleware/stack'

describe OmniAuth::ProviderRegistry::RailsMiddlewareSource do
  def configured_middlewares
    @configured_middlewares ||=
      begin
        stack = ActionDispatch::MiddlewareStack.new
        stack.use UnrelatedMiddleware1
        stack.use Strength
        stack.use OmniAuth::Builder do
          provider ConfiguredViaBuilder1, "X", "Y"
          provider :configured_via_builder2, "A", "B"
        end
        stack.use Charisma, "CLIENT_ID", "SECRET"
        stack.use UnrelatedMiddleware2
        stack.use OmniAuth::Builder do
          provider ConfiguredViaBuilder3
        end
        stack.use Dexterity, "CLIENT_ID", "SECRET", favorite_color: "red"
      end
  end

  require 'byebug'
  it "returns factory methods for all OmniAuth middleware" do
    source = OmniAuth::ProviderRegistry::RailsMiddlewareSource.new(configured_middlewares)
    provider_factories = source.providers
    provider_factories.length.must_equal 6
    provider_factories.each do |factory|
      factory.must_respond_to :call
    end
  end

  it "factory methods successfully return instances of strategies" do
    source = OmniAuth::ProviderRegistry::RailsMiddlewareSource.new(configured_middlewares)
    instances = source.providers.map{|p| p.call }
    instances.length.must_equal 6
    instances.each do |configured_provider|
      configured_provider.must_be_kind_of OmniAuth::Strategy
    end
  end

  it "providers added via 'use' have their configured values" do
    stack = ActionDispatch::MiddlewareStack.new
    stack.use Dexterity, "lorem", "ipsum",
        favorite_color: "green", favorite_number: 5

    source = OmniAuth::ProviderRegistry::RailsMiddlewareSource.new(stack)
    provider = source.providers.first.call
    provider.options["arg1"].must_equal "lorem"
    provider.options["arg2"].must_equal "ipsum"
    provider.options["site"].must_equal "http://example.com"
    provider.options["favorite_color"].must_equal "green"
    provider.options["favorite_number"].must_equal 5
  end

  it "providers added via OmniAuth::Builder have their configured values" do
    stack = ActionDispatch::MiddlewareStack.new
    stack.use OmniAuth::Builder do
      provider Dexterity, "lorem", "ipsum",
        favorite_color: "green", favorite_number: 5
    end
    source = OmniAuth::ProviderRegistry::RailsMiddlewareSource.new(stack)
    provider = source.providers.first.call
    provider.options["arg1"].must_equal "lorem"
    provider.options["arg2"].must_equal "ipsum"
    provider.options["site"].must_equal "http://example.com"
    provider.options["favorite_color"].must_equal "green"
    provider.options["favorite_number"].must_equal 5
  end
end

class FakeStrategy
  include OmniAuth::Strategy
  args [:first_arg, :second_arg]
end

class Strength < FakeStrategy; end
class Charisma < FakeStrategy; end
class Dexterity < FakeStrategy
  include OmniAuth::Strategy
  args [:arg1, :arg2]
  option :site, "http://example.com"
  option :favorite_color, "blue"
end

class ConfiguredViaBuilder1 < FakeStrategy; end
class OmniAuth::Strategies::ConfiguredViaBuilder2 < FakeStrategy; end
class ConfiguredViaBuilder3
  include OmniAuth::Strategy
end
class UnrelatedMiddleware1; end
class UnrelatedMiddleware2; end
