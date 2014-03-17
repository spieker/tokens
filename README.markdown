[![Gem Version](https://badge.fury.io/rb/ar-tokens.png)](http://badge.fury.io/rb/ar-tokens)
[![Build Status](https://travis-ci.org/spieker/tokens.png?branch=master)](https://travis-ci.org/spieker/tokens)
[![Code Climate](https://codeclimate.com/github/spieker/tokens.png)](https://codeclimate.com/github/spieker/tokens)

For generating a token on an active record column you can use `tokenize`

Parameters
----------

  * column: the column of the active record
  * options: some options for generating the token
    * :length: the token length (default: 8)
    * :uniq: whether the token must be uniq or not (default: true)
    * :scope: the column for the scope to check the uniqueness (default: nil)
    * :characters: an array of characters the tokens should be build from (default: a-zA-Z0-9)

Example
-------

```ruby
  class User < ActiveRecord::Base
    tokenize :email_confirmation_token, length: 16
  end
```

this is equal to

```ruby
  class User < ActiveRecord::Base
    before_validation on: :create do |obj|
      obj.generate_token :email_confirmation_token, length: 16
    end
  end
```

Installation
------------

Currently the gem is not available on rubyforge, so you have to install it with git:

```
  gem 'ar-tokens'
```

License
-------
This project rocks and uses MIT-LICENSE.
