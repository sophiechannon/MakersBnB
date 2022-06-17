require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require "./lib/property"
require "./lib/user.rb"
require "./lib/booking.rb"
require "date"
require 'pg'

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
    @properties = Property.all
    @user = User.find(id: session[:user_id]).email
    erb :'spaces/spaces'
  end

  get "/spaces/new" do
    erb :'/spaces/new'
  end

  post "/spaces/new" do
    @start_date = Date.parse(params[:availability_start])
    @end_date = Date.parse(params[:availability_end])
    if @start_date < @end_date 
      Property.create(name: params[:property_name], description: params[:description], price: params[:price].to_i, user_id: session[:user_id], availability_start: params[:availability_start], availability_end: params[:availability_end])
      redirect "/spaces"
    else
      flash[:notice] = "End date is before start date"
      redirect ("/spaces/new") 
    end
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

  get "/view-requests" do
    if ENV["ENVIRONMENT"] == "test"
      @connection = PG.connect(dbname: "makersbnb_test")
    else
      @connection = PG.connect(dbname: "makersbnb")
    end
    @sql_result = @connection.exec_params("SELECT bookings.id, bookings.booker_id, bookings.booking_date, bookings.booking_status, bookings.property_id, properties.property_name, users.first_name, users.last_name, users.email_address FROM bookings INNER JOIN properties ON bookings.property_id = properties.id INNER JOIN users on bookings.booker_id = users.id WHERE properties.user_id = $1",
    [session[:user_id]])
    puts @sql_result[0]
    # a Booking class object is not enough to hold all the data returns. need a new class?
    erb :'/requests/view'
  end

  run! if app_file == $0
end
