class AuthenticationController < ApplicationController

    # POST /login 

    TOKEN_VALIDITY=APP_CONFIG['toke_duration']
  
    def login
        begin 
            if !params['email'].present? or !params['password'].present? 
                render json: {message: "parameter missed"},status: 400
                return
            end 
    
            @user=User.find_by_email_and_status(params['email'],APP_CONFIG['user_status'][0])
    
            if @user.nil?
                render json: {message: "Invalid cedentials"},status: 404
                return
            end 
    
            if @user.password==params['password']
                token= Utility.encode(user_id: @user.id)
                time= Time.now + TOKEN_VALIDITY.hours.to_i
                render json: {token: token,expiry_time:time.strftime("%Y-%m-%d %H:%M:%S"),user: @user.attributes.slice("id","fname","lname","email","status","updated_at","created_at")}, status: 200
                return
            else 
                render json: {message: "invalid cedentials"},status: 401
            end 
        rescue StandardError => e
            render json: {message: e.message},status: 500
        end 
        

    end 
end
