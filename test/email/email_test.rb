require_relative '../test_config'
require './lib/email'

class EmailTest < MiniTest::Test
  def test_is_equal_for_same_email
    assert_equal Email.new('test@example.com'), Email.new('test@example.com')
  end

  def test_clears_white_space
    assert_equal Email.new('test@example.com'), Email.new('  test@example.com')
  end
end
