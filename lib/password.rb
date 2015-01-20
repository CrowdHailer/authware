require 'bcrypt'

class Password
  Invalid = Class.new(StandardError)
  def initialize(plain_text = nil, crypted: nil)
    @plain_text = plain_text
    @crypted = plain_text ? BCrypt::Password.create(plain_text) : BCrypt::Password.new(crypted)
  end

  def self.dump(item)
    item.dump
  end

  def self.load(crypted)
    new(crypted: crypted)
  end

  def dump
    @crypted.to_s
  end

  def ==(other)
    (@plain_text || @crypted) == other.to_s
  end

  protected
  def to_s
    @plain_text
  end
end
