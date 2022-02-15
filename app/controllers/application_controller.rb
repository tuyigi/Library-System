class ApplicationController < ActionController::API

  

    # authorize each and every request except login endpoint 
    
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = Utility.decode(header)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: {message: "unauthorized access"}, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: {message: "unauthorized access"}, status: :unauthorized
        end
      end

    
end
