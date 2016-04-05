class User < ApplicationRecord
  include Metal::EncryptedPassword

  validates :email, { presence: true, uniqueness: true }
  validates :encrypted_password, { presence: true }
end
