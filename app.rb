require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './config/environments' #database configuration
require './models/user'

enable :sessions

get '/' do
  erb :index
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello there'
  end
end

get '/signup/form' do
  if session[:user_id].nil?
    erb :signup
  end
end

post '/signup' do
    password = params[:password].strip
    confirm_password = params[:confirm_password].strip
    user = User.new(name: params[:name], email: params[:email])
    unless user.valid?
      redirect uri '/signup/form'
    end
    if password != confirm_password
      flash[:notice] = "Passwords entered don't match"
      redirect uri '/signup/form'
    end

    user.password = user.hash_password(params[:password])
    begin
      user.save
      users = User.find_by(email: params[:email])
      session[:user_id] = users.id
      redirect '/'
    rescue StandardError => e
      flash[:notice] = 'Similar user-name or email exists'
      redirect uri '/signup/form'
    end
  end
