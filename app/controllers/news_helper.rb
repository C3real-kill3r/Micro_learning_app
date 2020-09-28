require 'news-api'

class News_Api
  @@news_api = News.new ('5acea22c53e341949f3356679e3d7655')

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
