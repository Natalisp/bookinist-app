require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/'
    enable :sessions
    set :session_secret, "secret"
  end


  get '/' do 
     if user_signed_in?
      erb :'users/profile'
    else
      erb :'users/auth'
    end
  end

   helpers do
    def current_user
      @_current_user ||= User.find_by(id: session[:id])
    end

    def user_signed_in?
      !!current_user
    end

    def login(user)
      session[:id] = user.id
    end

    def logout
      session[:id] = nil
    end
  end

  not_found do
    status 404
    erb :oops
  end

end