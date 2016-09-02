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
     erb :index
  end

   helpers do

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def current_user
      User.find(session[:id])
    end

    def logged_in?
      !!session[:id]
    end

  end

  not_found do
    status 404
    erb :oops
  end

end