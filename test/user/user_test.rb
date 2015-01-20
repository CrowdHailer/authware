require_relative '../test_config'
require './lib/user'
require './lib/password'

class UserTest < MiniTest::Test
  def test_users
    email = Email.new('s@x.com')
    r = User::Record.new :email => email
    r.save
    r.reload

    assert_equal email, r.email
  end

  def test_password
    password = Password.new('password')
    r = User::Record.new :password => password
    r.save
    r.reload
    puts r.password == password
    puts r.password == Password.new('x')
  end
end
