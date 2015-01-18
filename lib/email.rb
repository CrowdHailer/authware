class Email
  def initialize(value)
    self.value = value
  end

  def value
    @value
  end

  def value=(new_value)
    @value = new_value.strip
  end

  def ==(other)
    value == other.value
  end
  # alias_method :eql?, :==
end
