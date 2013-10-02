source "http://rubygems.org"

# Specify your gem's dependencies in tokens.gemspec
gemspec
gem 'rspec'
gem 'sqlite3'
gem 'activerecord', '~> 3.1.0'

group :test do
  gem 'rake'
end

