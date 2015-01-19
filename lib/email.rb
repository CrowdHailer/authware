class Email
  Invalid = Class.new(StandardError)

  def initialize(value)
    self.value = value
  end

  def to_s
    value
  end
  alias_method :to_str, :to_s

  def value
    @value
  end

  def value=(new_value)
    @value = new_value.strip[/^[^@]+@[^@]+$/] || invalid(new_value)
  end

  def ==(other)
    value == other.value
  end
  # alias_method :eql?, :==

  private

  def invalid(bad_format)
    raise Invalid.new "'#{bad_format}' is not a valid email"
  end
end
