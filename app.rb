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
    session[:user_name] ? session[:user_name] : 'Hello there'
  end
end

get '/signup/form' do
  if session[:user_id].nil?
    erb :signup
  else
    session[:user_id] = nil
    erb :signup
  end
end

get '/login/form' do
  if session[:user_id].nil?
    erb :login
  else
    session[:user_id] = nil
    redirect uri '/login/form'
  end
end

get '/logout' do
  session.clear
  redirect uri '/login/form'
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
    redirect '/login/form'
  rescue StandardError => e
    flash[:notice] = 'The users already exist'
    redirect uri '/signup/form'
  end
end

post '/login' do
  user = User.find_by(email: params[:email])
  if !user.nil? and user.check_password(params[:password], user.password )
    session[:user_name] = user.name
    session[:user_id] = user.id
    flash[:notice] = 'Successfully logged in'
    sleep 3
    redirect uri '/'
  else
    flash[:notice] = 'Invalid login credentials'
    redirect uri '/login/form'
  end
end
