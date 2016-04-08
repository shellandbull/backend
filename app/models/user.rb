class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_secure_password
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates :email, { presence: true, uniqueness: true }
  validates :password_digest, { presence: true }
end
