require 'sinatra/activerecord'

class Category < ActiveRecord::Base
  has_many :users, through: :user_categories
  has_many :user_categories

  validates :name,
            presence: true
end