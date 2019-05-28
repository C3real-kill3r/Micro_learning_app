require 'news-api'

class News_Api
  @@news_api = News.new ('746b9b93077d454098492aa96bee42a6')

  # fetch specific category
  def fetch_specific_category(category)
    category = category.strip
    specific_category = @@news_api.get_top_headlines(
        language: 'en',
        category:category,
        country: 'us',
        sortBy: 'relevancy'
    )
  end
end