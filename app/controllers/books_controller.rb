class BooksController < ApplicationController

  get '/books' do 
    if !session[:id]
      redirect '/login'
    else
      @user = current_user
      @books = @user.books
      erb :'/books/books'
    end
  end

  # get '/books/new' do 
  #   if !session[:id].nil?
  #     erb :'/books/add_book'
  #   else
  #     redirect '/login'
  #   end
  # end

  post '/books' do 
    if logged_in?
      if !params[:name].nil? && !params[:name].empty?
        @book = Book.create(name: params[:name], user_id: current_user.id)
        current_user.books << @book
        current_user.save
        redirect '/books'
      else 
        redirect '/books'
      end
    else
      redirect '/login'
    end
  end

  # get '/books/:id/edit' do 
  #   if !session[:id].nil? && !params[:name].empty?
  #     @book = current_user.books.find_by_id(params[:id])
  #     erb :'/books/edit_book'
  #   else
  #     redirect '/login'
  #   end
  # end

  post '/books/:id/edit' do 
      @book = Book.find(params[:id])
      if !params[:name].empty? && @book.user_id == current_user.id
      @book.update(name: params[:name])
      redirect '/books'
      else 
      redirect '/login'
    end
  end

  post '/books/:id/delete' do 
    @book = Book.find(params[:id])
    if logged_in? && @book.user_id == session[:id]
       book.delete
       redirect '/books'
    else
       redirect '/login'
    end
  end



end
