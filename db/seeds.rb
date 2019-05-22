require_relative '../app/models/category'
require 'news-api'


newsapi = News.new('746b9b93077d454098492aa96bee42a6')

sources = newsapi.get_sources(country: 'us', language: 'en')

@categories = []
sources.each do |source|
  @categories.push(source.category)
end

@categories.uniq.each do |category|
  Category.create(name: category)
end
