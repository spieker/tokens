For generating a token on an active record column you can use `generate_token`

Parameters
----------

  * column: the column of the active record
  * options: some options for generating the token
  ** :length: the token length (default: 8)
  ** :uniq: whether the token must be uniq or not (default: true)
  ** :scope: the column for the scope to check the uniqueness (default: nil)

Example
-------

```ruby
  class User < ActiveRecord::Base
    before_validation do |obj|
      obj.generate_token :email_confirmation_token, :length => 16
    end
  end
```

Installation
------------

Currently the gem is not available on rubyforge, so you have to install it with git:

```
  gem 'tokens', :git => 'git://github.com/spieker/tokens.git'
```

