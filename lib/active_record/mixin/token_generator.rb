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
        # * columns: the column of the active record as symbol or an array of columns
        # * options: some options for generating the token
        # ** :length: the token length (default: 8)
        # ** :uniq: whether the token must be uniq or not (default: true)
        # ** :scope: the column for the scope to check the uniqueness (default: nil)
        # ** :same_token: if an array of columns is given and this option is true, all columns will get the same token (default: false)
        #
        # == Example
        #   class User < ActiveRecord::Base
        #     before_validation do |obj|
        #       obj.generate_token :email_confirmation_token, :length => 16
        #     end
        #   end
        #
        def generate_token(columns, *args)
          options = {
            :length     => 8,
            :uniq       => true,
            :scope      => nil,
            :same_token => false,
            :max_try    => 8
          }.merge(args.extract_options!)
          
          columns = [columns] unless columns.is_a?(Array)
          
          result = {}
          token = nil
          columns.each do |column|
            counter = 0
            begin
              raise NoFreeToken.new(column) if counter >= options[:max_try]
              counter += 1

              token = new_token(options[:length]) if(token.blank? or not options[:same_token])
              self.send("#{column}=".to_sym, token)
              result[column.to_sym]      = token
              condition                  = { column => token }
              condition[options[:scope]] = self[options[:scope]] if options[:scope].is_a?(Symbol) or options[:scope].is_a?(String)
            end while options[:uniq] and self.class.exists?(condition)
          end
          result
        end

      end

      module ClassMethods
        # this method generates a token for the given columns before there get validated. Beside the
        # options described at the +generate_token+ method, you can use the following options.
        #
        # :on: (default: :create)
        #
        def tokenize(column, *args)
          options = {
            :on => :create
          }.merge(args.extract_options!)
          before_validation_options = options.reject { |k,v| [:length, :uniq, :scope, :same_token].include?(k) }
          options.select! { |k,v| [:length, :uniq, :scope, :same_token].include?(k) }

          before_validation before_validation_options do |obj|
            obj.generate_token column, options
          end  
        end
      end
  
      def self.included(receiver)
        receiver.send :include, InstanceMethods
        receiver.extend ClassMethods
      end
    end
  end
end

ActiveRecord::Base.send :include, ActiveRecord::Mixin::TokenGenerator
