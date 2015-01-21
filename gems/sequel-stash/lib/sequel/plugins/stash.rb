require "sequel/plugins/stash/version"

module Sequel
  module Plugins
    module Stash
      def self.apply(model)
        model.plugin :serialization
      end

      module ClassMethods
        def stash(item)
          klass =Kernel.const_get(item)
          serialize_attributes [klass.method(:dump), klass.method(:load)], item.downcase
        end
      end
    end
  end
end
