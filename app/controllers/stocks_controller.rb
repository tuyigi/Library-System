class StocksController < ApplicationController
    before_action :authorize_request
    
    before_action :getInfo , only:[:stockMovement]
    

    # POST /stockmovement
    def stockMovement
        begin 
            if !params['quantity'].present? or !params['book_id'].present? or !params['user_id'].present? or !params['status'].present? or !params['movement_type'].present? 
                render json: {message: 'some info are missing'}
                return
            end 
    
            if !APP_CONFIG['stock_status'].include? params['status']
                render json: {message: 'invalid status'}
                return
            end
    
            if !APP_CONFIG['stock_type'].include? params['movement_type'] or params['movement_type']==APP_CONFIG['stock_type'][2]
                render json: {message: "invalid movement type"}
                return
            end 
    
            if params['movement_type']==APP_CONFIG['stock_type'][1] and params['quantity'].to_i>@book.quantity.to_i
                render json: {message: 'insuficience items avaialable in stock'}
                return
            end 
            new_quantity=@book.quantity

            if params['movement_type']==APP_CONFIG['stock_type'][1]
                new_quantity=@book.quantity.to_i-params['quantity'].to_i
            end 

            if params['movement_type']==APP_CONFIG['stock_type'][0]
                new_quantity=@book.quantity.to_i+params['quantity'].to_i
            end 
            
            @book.quantity=new_quantity
            @book.save
            @stock=Stock.create!(book_id: params['book_id'],user_id: params['user_id'],quantity: params['quantity'],movement_type: params['movement_type'],status:params['status'])
            render json: @stock, status: 201
        rescue StandardError =>e
            render json: {message: e.message},status: 500
        end 
    end


    # POST /stockmovementhistory 

    def movementHistory
        begin 
            if !params['start_date'] or !params['end_date']
                render json: {message:"missed some params"}, status: 400
                return
            end
            page=1
            per=10
            if params['page'].present? 
                page=params['page']
            end 
            if params['per_page'].present? 
                per=params['per_page']
            end 
            @movement=Stock.with_start_date(params['start_date']).with_end_date(params['end_date']).with_book_id(params['book_id']).with_user_id(params['user_id']).with_movement_type(params['movement_type']).order("stocks.id ASC").page(page).per(per)
            render json: @movement, status: 200
            return
        rescue StandardError => e
            render json: {message:e.message}, status: 500
            return
        end 
    end 



    private 
    def getInfo
        @book=Book.where(id: params['book_id'],status:'PUBLISHED').first
        if @book.nil?
            render json: {message: "book not found by id #{params['book_id']}"},status:404
            return
        end 
        @user=User.where(id: params['user_id']).first
        if @user.nil?
            render json: {message: "user not found by id #{params['user_id']}"},status:404
            return
        end
    end 
    
end
