require 'news-api'

class News_Api
  @@news_api = News.new ('746b9b93077d454098492aa96bee42a6')

  # fetch all categories from an endpoint
  def fetch_all_categories
    everything = @@news_api.get_everything(
      language: 'en',
      sources:'techcrunch,talksport,the-next-web,
                national-geographic, al-jazeera-english,
                crypto-coins-news',
      page: 1
  )
  end

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

  # get random content to send to the user
  def get_random_content
    random_content = []
    fetch_all_categories.each do |link_to_send|
      random_content = link_to_send.url

    end
    random_content.sample
  end
end