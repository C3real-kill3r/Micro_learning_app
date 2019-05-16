require_relative '../models/category.rb'

def add_categories(single_selected)
    @session = session[:user_id]
    user = User.find_by(id: @session)
    category = Category.find_by(name: single_selected)
    user.categories << category unless user.categories.include? category
end