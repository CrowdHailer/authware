require_relative '../test_config'
require './lib/user'

class UserTest < MiniTest::Test
  def test_users
    email = Email.new('s@x.com')
    r = User::Record.new :email => email
    r.save
    r.reload

    assert_equal email, r.email
  end
end
