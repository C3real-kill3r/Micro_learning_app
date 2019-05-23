ENV['RACK_ENV'] = 'test'

require_relative '../../app/controllers/microlearning_controller'
require 'rspec'
require 'rack/test'


module MicrolearningApp
    RSpec.describe 'Micro Learning App' do
        include Rack::Test::Methods

        def app
            MicrolearningController.new
        end

        it "should display homepage" do
            get '/'
            expect(last_response).to be_ok
        end

        it "should display signup page" do
            get 'signup/form'
            expect(last_response).to be_ok
        end

        it "should display login page" do
            get 'login/form'
            expect(last_response).to be_ok
        end

        it "should restrict access to categories page when unauthenticated" do
            get '/select_categories'
            expect(last_response.status) == 403
        end

        it "should restrict access to results page when unauthenticated" do
            get '/results'
            expect(last_response.status) == 403
        end

        it 'should redirect to login after signup' do
            before_count = User.count

            post '/signup',  { name: 'johndoe', email: 'johndoe@gmail.com', password: 'Johndoe123!@#', confirm_password: 'Johndoe123!@#'}
            expect(User.count).not_to eq(before_count)
            expect(last_response).to be_redirect
            follow_redirect!
            expect(last_request.path).to eq('/login/form')
        end

        it "should not allow duplicate registration" do
            before_count = User.count

            post '/signup',  { name: 'johndoe', email: 'johndoe@gmail.com', password: 'Johndoe123!@#', confirm_password: 'Johndoe123!@#'}
            after_count = User.count
            post '/signup',  { name: 'johndoe', email: 'johndoe@gmail.com', password: 'Johndoe123!@#', confirm_password: 'Johndoe123!@#'}
            expect(User.count).to eq(after_count)
        end

        it "should login registered users" do
            post '/signup',  { name: 'johndoe', email: 'johndoe@gmail.com', password: 'Johndoe123!@#', confirm_password: 'Johndoe123!@#'}
            post '/login',  { email: 'johndoe@gmail.com', password: 'Johndoe123!@#'}
            expect(last_response).to be_redirect
            follow_redirect!
            expect(last_request.path).to eq('/select_categories')
        end

        it "should not login uregistered users" do
            post '/login',  { email: 'janedoe@gmail.com', password: 'Johndoe123!@#'}
            expect(last_response).to be_redirect
            follow_redirect!
            expect(last_request.path).to eq('/login/form')
        end

        it "should logout a logged in user" do
            post '/signup',  { name: 'johndoe', email: 'johndoe@gmail.com', password: 'Johndoe123!@#', confirm_password: 'Johndoe123!@#'}
            post '/login',  { email: 'johndoe@gmail.com', password: 'Johndoe123!@#'}
            get "/logout"
            expect(last_response).to be_redirect
            follow_redirect!
            expect(last_request.path).to eq('/login/form')
        end
    end
end
