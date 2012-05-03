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
  def self.new_token(length=8, characters = ('a'..'z').to_a+('A'..'Z').to_a+(0..9).to_a)
    result = ''
    length.times { result += characters.shuffle.first.to_s }
    result
  end
  
  def new_token(length=8, characters = ('a'..'z').to_a+('A'..'Z').to_a+(0..9).to_a)
    self.class.new_token(length, characters)
  end
end
