class User < ApplicationRecord
  has_secure_password

  validates :email, { presence: true, uniqueness: true }
  validates :encrypted_password, { presence: true }
end
