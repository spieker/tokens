require 'active_record'
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :token_tests do |t|
  t.string :scope
  t.string :token
  t.string :token_two
  t.timestamps
end

class TokenTest < ActiveRecord::Base
  set_table_name 'token_tests'
end
