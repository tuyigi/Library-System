class UsersController < ApplicationController


    before_action :authorize_request
    before_action :user_details , only:[:getUser,:blockUser,:unblockUser]


    # GET /users
    def getAll
        @users=User.all
        render json: @users
    end

    # POST /users
    def newUser
        begin
            user=User.create!(user_params)
            render json: user
            return
        rescue StandardError => e
            render json: {message:e.message}, status:500
        end 
    end 

    # PUT /block user

    def blockUser
        begin
            if @user.status==APP_CONFIG['user_status'][2]
                render json: {message: "user already blocked"},status: 400
                return
            end
            @user.update(status:APP_CONFIG['user_status'][2])
            render json: {message: "user blocked successful"},status: 200
            return
        rescue StandardError => e
            render json: {message: e.message},status: 500
        end 
    end 


    # PUT /unblock user

    def unblockUser 
        begin 
            if @user.status!=APP_CONFIG['user_status'][2] 
                render json: {message: "user is not blocked"}, status: 400
                return
            end   
            @user.update(status:APP_CONFIG['user_status'][0])
            render json:{message: "user activated successfully"},status:200
            return
        rescue StandardError => e
            render json: {message: e.message},status: 500
            return
        end 
    end 

    # GET user/:id
    def getUser
        begin
            if @user.nil?
                render json: {message:"user not available"}, status: 404
            else
                render json: @user
            end 
        rescue StandardError => e
            render json: {message: e.message},status: 500
        end 
    end 

    private 

    def user_params
        params.require(:user).permit(:fname,:lname,:email,:password)
    end

    def user_details
        if !params[:id].present?
            render json:{message: "Missed parameter"}, status: 400
            return
        end 
        @user=User.where(id: params[:id]).first
        if @user.nil?
            render json: {message: "user not found"}
            return
        end

    end 

end
