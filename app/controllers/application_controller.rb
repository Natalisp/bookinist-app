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
    binding.pry
    erb :index
  end

  get '/signup' do 
    erb :'/users/create_user'
  end


end