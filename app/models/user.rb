require 'sinatra/activerecord'
require 'bcrypt'

class User < ActiveRecord::Base
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name,
            :presence => true,
            :uniqueness => true

  validates :email, format: {
      with: EMAIL,
      message: "Incorrect email format, try example@example.com"},
      :uniqueness => true

  has_many :user_categories
  has_many :categories, through: :user_categories

  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end

  # compare hashed password with the password given
  def check_password(password, hash)
    BCrypt::Password.new(hash) == password
  end
end