require "bcrypt"
require "active_support"

module Metal
  module EncryptedPassword
    extend ActiveSupport::Concern

    included do
      include BCrypt

      def password
        @password ||= Password.new(encrypted_password)
      end

      def password=(new_password)
        @password = Password.new(new_password)
        self.encrypted_password = @password
      end
    end
  end
end
