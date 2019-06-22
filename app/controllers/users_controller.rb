class UsersController < ApplicationController
    get '/new' do
        erb :"/test"
      end

      post "/users/new" do 
        #signinp up the user
       # @user = User.create(username: params[:username], email: params[:email], password: params[:password])
       # @user = User.create(username:params[:username], email: params[:email], password: params[:password])
       @name = params[:username]
       @mail = params[:email]
       @pass = params[:password]
       #binding.pry
        if !logged_in?
          if @name=="" || @mail=="" || @pass==""
            redirect to "/"
          else
            @user = User.new(username: @name, email: @mail, password: @pass)
            if @user.save
              session[:user_id] = @user.id
              redirect to "/books"
            end 
          end
        end
      else
        redirect to "/books"
      end

      get "/login" do
        erb :"/users/login"
      end

      post "/login" do 
        @name=params[:username]
        @pass=params[:password]
        if logged_in?
          redirect to "/books"
        else
          @user = User.find_by(username: @name)
          if @user && @user.authenticate(@pass)
            session[:user_id] = @user.id 
            redirect to "/books"
          else
            "User not found -  Please create an account and try again"
          end
        end
      end


      get "/logout" do 
        if logged_in?
          session
          #binding.pry
          session.destroy
          redirect to "/login"
          #" Session Hash destroyed - logged out"
          else
            redirect to "/login"
            #"You're not logged in"
        end
      end

    get "/success" do
        "User created"
    end


    
  end