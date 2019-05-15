require 'sinatra/activerecord'
require 'bcrypt'

class User < ActiveRecord::Base
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name,
            presence: true

  validates :email, format: {
      with: EMAIL,
      message: "Email format not correct e.g. example@example.com"}

  # hash a password
  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end

  # compare hashed password with the password given
  def test_password(password, hash)
    BCrypt::Password.new(hash) == password
  end
end