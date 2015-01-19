require './lib/email'
Sequel::Model.db = Sequel.connect('sqlite://db/app.db')

class User
  class Record < Sequel::Model(:users)
    plugin :serialization
    serialize_attributes [lambda(&:dump), Email.method(:new)], :email

  end

end
