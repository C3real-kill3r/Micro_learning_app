require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/form_helpers'
require 'news-api'

require_relative '../models/user'
require_relative '../models/category'
require_relative '../models/user_category'
require_relative './add_categories'
require_relative './news_helper'


class MicrolearningController < :: Sinatra::Base
  helpers Sinatra::FormHelpers
  register Sinatra::Flash

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

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

  get '/select_categories' do
    if !session[:user_id].nil?
      @session = session[:user_id]
      user = User.find_by(id: @session)
      all_categories = Category.all
      categories_zote = all_categories.each.map { |category| category.name }
      user_categories = user.categories.each.map {|cat| cat.name}
      all_categories = categories_zote - user_categories
      erb :categories, locals: { cat: all_categories, user_cat: user_categories}
    else
      redirect uri '/login/form'
    end
  end

  get '/logout' do
    session.clear
    redirect uri '/login/form'
  end

  get '/results' do
    if !session[:user_id].nil?
      @session = session[:user_id]
      user = User.find_by(id: @session)
      user_cats = user.categories.each.map {|cat| cat.name }
      category = user_cats.first
      if category
        news = News_Api.new
        fetched = news.fetch_specific_category category
        erb :results, locals: {all_categories: user_cats, fetched: fetched}
      else
        flash[:error] = "You have not selected a category yet"
        redirect uri '/select_categories'
      end
    else
      redirect uri '/login/form'
    end
  end

  not_found do
    status 404
    erb :oops
  end

  post '/signup' do
      password = params[:password].strip
      confirm_password = params[:confirm_password].strip
      user = User.new(name: params[:name], email: params[:email])
      unless user.valid?
        flash[:notice] = "Email format not correct e.g. example@example.com"
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
      rescue StandardError => error
        flash[:notice] = 'Similar user-name or email exists'
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
      redirect uri '/select_categories'
    else
      flash[:notice] = 'Invalid login credentials'
      redirect uri '/login/form'
    end
  end

  post '/select_categories' do
    if !session[:user_id].nil?
      selected = params[:category]
      if !selected
        redirect uri '/select_categories'
      else
        selected = params[:category]['choose']
        selected = selected.kind_of?(Array) ? selected : [selected]
        unless selected.empty?
          selected.each do |single_selected|
            add_categories(single_selected)
          end
        end
        redirect uri '/select_categories'
      end
    end
  end

  post '/deselect_category' do
    @session = session[:user_id]
    user = User.find_by(id: @session)
    remove = params[:delete]
    if remove
      user.categories.delete(Category.find_by(name: params[:delete]))
    end
    redirect uri '/select_categories'
  end
end
