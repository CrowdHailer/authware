class Email
  def initialize(value)
    @value = value
  end

  def value
    @value
  end

  def ==(other)
    value == other.value
  end
  # alias_method :eql?, :==
end
