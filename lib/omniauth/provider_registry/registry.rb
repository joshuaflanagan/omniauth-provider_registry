module OmniAuth
  module ProviderRegistry
    class Registry
      attr_reader :factory_methods

      def initialize(factory_methods)
        @factory_methods = factory_methods
      end

      def find(name)
        factory = factories_by_name[name.to_sym]
        factory.call if factory
      end

      def factories_by_name
        @factories_by_name ||= factory_methods.each_with_object({}){|f, all|
          name = f.call.name.to_sym
          all[name] = f
        }
      end
    end
  end
end
