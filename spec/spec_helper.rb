require 'rubygems'
require 'bundler/setup'

require 'ar-tokens'
require 'support/active_record'

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
