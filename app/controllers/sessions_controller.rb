class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:create, :index, :show, :update, :destroy]

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user
    else
      render json: { errors: ["Invalid Name or password"] }, status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end
  

end
