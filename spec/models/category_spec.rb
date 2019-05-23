ENV['RACK_ENV'] = 'test'

require_relative '../../app/models/category'
require_relative '../support/database_cleaner'


module MicrolearningApp
  RSpec.describe 'Category Model' do
    let(:category_model) {
      Category.new('name' => 'test_user')
    }
    describe 'category' do
      context 'with an empty entry' do
        it 'should not allow empty entry' do
          category_model.name = ""
          result = category_model.valid?

          expect(result).not_to eq(true)
        end
      end

      context 'with a valid entry' do
        it 'should successfully add the category' do
          result = category_model.save!

          expect(result).to eq(true)
        end
      end
    end
  end
end