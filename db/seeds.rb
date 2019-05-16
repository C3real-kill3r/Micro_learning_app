require_relative '../models/category'

categories = [
    {name: 'entertainment'},
    {name: 'politics'},
    {name: 'religion'},
    {name: 'weather'},
    {name: 'business'},
    {name: 'science'},
    {name: 'sports'},
    {name: 'technology'},
    {name: 'health'},
    {name: 'traffic'},
    {name: 'breaking news'}
]

categories.each do |category|
  Category.create(category)
end