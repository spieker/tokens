class NoFreeToken < Exception
  def initialize(column)
    super("No free token for column '#{column}' found")
  end
end
