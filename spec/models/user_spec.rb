ENV['RACK_ENV'] = 'test'

require_relative '../../app/models/user'
require_relative '../support/database_cleaner'

module MicrolearningApp
  RSpec.describe 'User Model' do
    let(:user_model) {
      User.new('email' => 'johndoe@gmail.com',
               'name' => 'johndoe',
               'password' => 'Johndoe123!@#'
      )
    }
    describe 'user' do
      context 'with a valid user' do
        it 'should successfully add a user' do
          result = user_model.save!

          expect(result).to eq(true)
        end
      end

      context 'with a invalid user entry' do

        it 'should reject empty name' do
          user_model.name = ""
          result = user_model.valid?

          expect(result).not_to eq(true)
        end

        it 'should reject invalid email' do
          user_model.email = "johndoe@com"
          result = user_model.valid?

          expect(result).not_to eq(true)
        end

      end
    end
  end
end