class User < ApplicationRecord
  validates :email, { presence: true, uniqueness: true }
  validates :encrypted_password, { presence: true }
end
