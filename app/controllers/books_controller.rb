class BooksController < ApplicationController
    before_action :get_book,only:[:showBook,:update_book]
    before_action :authorize_request
    # GET /books
    def getAllBook
        books=Book.all
        render json: books , status: 200
    end 

    # GET /books
    def showBook
        @book
        render json: @book, status: 200
    end 

    #POST /book
    def newBook
        begin
            if !params[:title].present? or !params[:author].present? or !params[:release_year].present? or !params[:price].present? or !params[:status].present?
                render json:{message:"empty parameters detected"}, status:400
                return
            end
    
            if !APP_CONFIG['book_status'].include? params[:status]
                render json: {message: "invalid book status"},status:400
                return
            end
            @book=Book.create!(title: params[:title],author: params[:author],price: params[:price],status: params[:status],quantity: 0,release_year: params[:release_year])
            render json: {message: "new book recorded successfuly"},status:201
            return
        rescue StandardError => e
            render json: {message:e.message},status:500
        end 
        



    end 

    #PUT /book
    def update_book

        begin
            if @book
                @book.update(title: params[:title],author: params[:author],price: params[:price],status: params[:status],release_year: params[:release_year])
                render json: {message:"book updated successfuly",data:@book},status:200
            else
                render json:{message: "unable to update book"},status: 400
            end
        rescue StandardError => e
            render json:{message:e.message}
        end
    end
    

    private
    def get_book
        begin 
            @book=Book.find(params[:id])
        rescue StandardError => e
            render json: {message: e.message}, status:404
        end 
    end 

    def book_params
        params.require(:Book).permit(:title,:author,:release_year,:price,:status)
    end 
end
