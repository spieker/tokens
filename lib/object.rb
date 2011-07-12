# This provides a method for generating a random token of the given length.
# The generated token is base58 encoded, so the token just contains numbers,
# up- and down case characters.
# 
# Example:
#   Object.new_token(10) # => "S2Mq4mJBv6" (i.e.)
# or
#   Object.new.new_token(10) # => "S2Mq4mJBv6" (i.e.)
#
class Object
  def self.new_token(length=8)
    Base58.encode(SecureRandom.random_number(58**length))
  end
  
  def new_token(length=8)
    self.class.new_token(length)
  end
end