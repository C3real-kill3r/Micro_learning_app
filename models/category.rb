require 'sinatra/activerecord'

class Category < ActiveRecord::Base
  has_many :users

  validates :name,
            presence: true
end