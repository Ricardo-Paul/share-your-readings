class BooksController < ApplicationController



    get "/books" do 
        @books = Book.all
        #binding.pry
        erb :"/books/books"
    end

    get '/books/new' do
        erb :"/books/new"
    end

    get "/books/my_books" do 
        @books = current_user.books
        erb :"/books/my_books"
    end

    post '/books' do
        @title = params[:title]
        @author = params[:author]
        @summary = params[:summary]
        @quote = params[:quote]
        if logged_in?
            if @title!="" && @author!="" && @summary!="" && @quote!=""
                @book = current_user.books.build( title: @title, author: @author, summary: @summary, quote: @quote )
                if @book.save
                    redirect to "/books"
                end
                #binding.pry  
            else
                "Empty"
            end
        end
    end

    get '/books/:id/edit' do
        @book = Book.find_by(id: params[:id])
        erb :"/books/edit"
    end


  patch '/books/:id/edit' do
    @title = params[:title]
    @author = params[:author]
    @summary = params[:summary]
    @quote = params[:quote]
    @book = Book.find_by(id: params[:id])
    binding.pry
    if @book && @book.user == current_user
        @book.update(title: @title, author: @author, summary: @summary, quote: @quote)
        redirect to "/books"
    end
  end

end