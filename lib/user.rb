require './lib/email'
Sequel::Model.db = Sequel.connect('sqlite://db/app.db')

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
class User
  class Record < Sequel::Model(:users)

    plugin Sequel::Plugins::Stash
    # serialize :Email, :at => :contact_email
    stash :Email
  end

end
