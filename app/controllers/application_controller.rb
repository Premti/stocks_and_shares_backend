class ApplicationController < ActionController::API
    # before_action :authorized
 
  def encode_token(payload)
    # should store secret in env variable
    JWT.encode(payload, 'my_s3cr3t')
  end
 
  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end
 
  def decoded_token
    if auth_header
      token = auth_header
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'my_s3cr3t')
      rescue JWT::DecodeError
        nil
      end
    end
  end
 
  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end
 
  # def logged_in?
  #   !!current_user
  # end
 
  # def authorized
  #   if logged_in?
  #     render json: { message: 'Welcome' }, status: :ok
  #   else
  #     render json: { message: 'Please log in' }, status: :unauthorized
  #   end
  # end
end
