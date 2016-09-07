require 'pry'

class BooksController < ApplicationController

  get '/books' do 
    if !session[:id]
      redirect '/login'
    else
      @user = current_user
      if params[:sort_books] && params[:sort_books] == 'true'
        @books = @user.books.order(:have_read)
        @books_sorted = true
      else 
        @books_sorted = false
        @books = @user.books
      end
      erb :'/books/books'
    end
  end

  get '/books/new' do 
    redirect to '/books'
  end

  get '/books/:id/edit' do 
    redirect to '/books'
  end

  post '/books' do 
    if logged_in?
      if !params[:name].nil? && !params[:name].empty?
        binding.pry
        @book = Book.create(name: params[:name], user_id: current_user.id, have_read: false)
        current_user.save
        redirect '/books'
      else 
        redirect '/books'
      end
    else
      redirect '/login'
    end
  end

  patch '/books/:id/edit' do 
    @book = Book.find(params[:id])
    if !params[:name].empty? && @book.user_id == current_user.id
        @book.update(name: params[:name])
        redirect '/books'
    else 
        redirect '/login'
   end
  end

  patch '/books/:id/have_read' do 
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
        @book.update(have_read: !@book.have_read)
        redirect '/books'
    else 
        redirect '/login'
   end
  end

  delete '/books/:id' do 
    if Book.find(params[:id])
       Book.find(params[:id]).delete
       redirect '/books'
     else
       not_found
    end
  end

end
