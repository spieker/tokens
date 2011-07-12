# This mixin provides methods on ActiveRecord::Base to generate a token for
# a given column. The token for the column can have a specific length, can
# be uniq and the uniqueness can be scoped on a given column.
#
module ActiveRecord
  module Mixin
    module TokenGenerator
      module InstanceMethods
        # Generates a token for the given active record column
        #
        # == Parameters
        # * column: the column of the active record
        # * options: some options for generating the token
        # ** :length: the token length (default: 8)
        # ** :uniq: whether the token must be uniq or not (default: true)
        # ** :scope: the column for the scope to check the uniqueness (default: nil)
        #
        # == Example
        #   class User < ActiveRecord::Base
        #     before_validation do |obj|
        #       obj.generate_token :email_confirmation_token, :length => 16
        #     end
        #   end
        #
        def generate_token(column, *args)
          options = {
            :length => 8,
            :uniq   => true,
            :scope  => nil
          }.merge(args.extract_options!)
      
          begin
            self[column]               = new_token(options[:length])
            condition                  = { column => self[column] }
            condition[options[:scope]] = self[options[:scope]] if options[:scope].is_a?(Symbol)
          end while options[:uniq] and self.class.exists?(condition)
        end
      end
  
      def self.included(receiver)
        receiver.send :include, InstanceMethods
      end
    end
  end
end

ActiveRecord::Base.send :include, ActiveRecord::Mixin::TokenGenerator