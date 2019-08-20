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
                    flash.next[:success] = "Book successfully created"
                    #redirect to "/books"
                    redirect to "/books/#{@book.id}/show"
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
    #binding.pry
    if @book && @book.user == current_user
        @book.update(title: @title, author: @author, summary: @summary, quote: @quote)
        @book.save
        redirect to "/books/#{@book.id}/show"
        flash.next[:update] = "Book Updated Successfully"
    else
        flash.next[:error] = " You cannot Edit that book "
        redirect to "/books"
    end
  end

  get '/books/:id/show' do
    @book = Book.find_by(id: params[:id])
    erb :"/books/show"
  end

  delete '/books/:id/delete' do
    @book = Book.find_by(id: params[:id])
    if @book && @book.user == current_user
        @book.delete
        redirect to "/books"
    else
        flash.next[:error] = " Not your book"
        redirect to "/books"
    end
  end




end