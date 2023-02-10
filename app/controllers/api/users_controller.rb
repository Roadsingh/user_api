class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  
  def index 
    @users = User.find_by(email: params[:email])
    response = {:fullname => "#{@users.first_name} #{@users.last_name}", :age => "#{@users.age}"}
    render json: response

  end

  def create
    @user = User.new(user_params)
    if @user.save 
      render json: @user
    else 
      render error: {error: "unable to create data"},status: 400
    end
end
       
private 
   def user_params
    params.require(:user).permit(:first_name , :last_name , :age , :email)
   end
end
