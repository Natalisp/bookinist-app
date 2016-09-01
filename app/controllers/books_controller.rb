class BooksController < ApplicationController

get '/books' do 
  if !session[:id]
    redirect '/login'
  else
    @user = current_user
    @books = @user.books
end

end
