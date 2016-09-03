require 'pry'

class UsersController < ApplicationController

  get '/signup' do

    if !session[:id]
      erb :'/users/create_user'
    else 
      redirect '/books'
    end
  end

  post '/signup' do 
    if params[:name] == nil || params[:email] == nil || params[:password] == nil
      redirect '/signup'
    else
      user = User.create(name: params[:name], email: params[:email], password: params[:password])
      user.save
      session[:id] = user.id
      redirect '/books'
    end
  end

  get '/login' do 
    if logged_in?
      redirect '/books'
    else
      erb :'/users/login'
    end
  end

  post '/login' do 
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/books'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    session[:id] = nil
   erb :'/logout'
  end


end