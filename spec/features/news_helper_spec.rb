ENV['RACK_ENV'] = 'test'

require 'rack/test'

module MicrolearningApp
  RSpec.describe News_Api do
    include Rack::Test::Methods
    let(:category_name) {"sports"}
    def app
      News_Api.new
    end

    describe 'news_helper' do
      it "should fetch specific categories" do
        allow(app).to receive(:fetch_all_categories)
                          .with(:category_name)
                          .and_return({
                                          'name' => "ESPN",
                                          'url'=> 'https://www.espn.com',
                                          'url_to_image' => "https//www.cnn/espn.png"
                                      })
      end
    end
  end
end