require './config/environment'
#require 'sinatra/base'
#require 'sinatra/flash'
#require "bundler/setup"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "reading_secret"
    #use Rack::Flash
    register Sinatra::Flash
  end

  get "/" do
    erb :welcome
  end

  get '/welcome' do
    erb :"/welcome"
  end

  helpers do 

    def logged_in?
      !!current_user
    end

    def current_user
      #binding.pry
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
  end

end
