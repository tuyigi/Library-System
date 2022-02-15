class UsersController < ApplicationController


    before_action :authorize_request


    # GET /users
    def getAll
        @users=User.all
        render json: @users
    end

    # POST /users
    def newUser
        begin
            @user=User.create!(user_params)
            render json: @user
        rescue StandardError => e
            render json: {message:e.message}, status:500
        end 
    end 

    # GET user/:id
    def getUser
        begin

            user=User.where(id: params[:id]).first
            if user.nil?
                render json: {message:"user not available"}, status: 404
            else
                render json: user
            end 
        rescue StandardError => e
            render json: {message: e.message},status: 500
        end 
    end 

    private 

    def user_params
        params.require(:user).permit(:fname,:lname,:email,:password)
    end

end
