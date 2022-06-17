require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require "./lib/property"
require "./lib/user.rb"
require "./lib/booking.rb"
require "./lib/property_filter.rb"

class Makersbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions

  get "/" do
    @user = User.find(id: session[:user_id])
    erb :index
  end

  post "/user" do
    user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect "/spaces"
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post "/sessions/new" do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect "/spaces"
    else
      flash[:notice] = "Please check your email or password."
      redirect ("/sessions/new")
    end
    session[:user_id] = user.id
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  get "/spaces" do
    @properties = PropertyFilter.dates
    @user = User.find(id: session[:user_id]).email
    erb :'spaces/spaces'
  end

  get "/spaces/new" do
    erb :'/spaces/new'
  end

  post "/spaces/new" do
    Property.create(name: params[:property_name], description: params[:description], price: params[:price].to_i, user_id: session[:user_id], availability_start: params[:availability_start], availability_end: params[:availability_end])
    redirect ("/spaces")
  end

  post "/spaces/filter" do
    PropertyFilter.set_dates(start_date: params[:available_from], end_date: params[:available_to])
    redirect ('/spaces')
  end

  post "/spaces/reset" do
    p params
    PropertyFilter.set_dates(start_date: params[:available_from], end_date: params[:available_to])
    redirect ('/spaces')
  end

  get "/spaces/:id" do
    @property = Property.find(id: params[:id])
    erb :'/spaces/booking'
  end

  post "/spaces/:id/book" do
    @booking = Booking.create(user_id: session[:user_id], date: params["date"], property_id: params["id"])
    @property = Property.find(id: @booking.property_id)
    erb :'/spaces/request_submission'
  end

  run! if app_file == $0
end
