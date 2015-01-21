require './lib/password'
require 'sequel/plugins/stash'
Sequel::Model.db = Sequel.connect('sqlite://db/app.db')

class User
  class Record < Sequel::Model(:users)
    plugin :stash

    def initialize(*args, &block)
      super
      self.id ||= SecureRandom.uuid()
    end

    stash :Email
    stash :Password
  end

end
