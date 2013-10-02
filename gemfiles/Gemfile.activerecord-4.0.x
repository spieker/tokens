source "http://rubygems.org"

# Specify your gem's dependencies in tokens.gemspec
gem 'rspec'
gem 'sqlite3'
gem 'activerecord', '~> 4.0.0'

group :test do
  gem 'rake'
end

