require './lib/email'
Sequel::Model.db = Sequel.connect('sqlite://db/app.db')

class User
  class Record < Sequel::Model(:users)
    plugin :serialization
    serialize_attributes Email.serialization_map, :email
    # serialize_attributes [Email.dump_it, Email.load_it], :email
    # Use dump class method to check that item is one of suggested save types, i.e. is instance of class or class child
    serialize :Email
    serialize :Email, :at => :contact_email
    serialize :Password
    serialize :ResetToken

  end

end
