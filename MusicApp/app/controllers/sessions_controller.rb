class SessionsController < ApplicationController

  def create

    user = User.find_by(email: params[:user][:email])

    render plain: "user not found" if user.nil?
    debugger
    if user.valid_password?(params[:user][:password])
      @user = user
      login!(user)
      render :show
      debugger
    else
      #render json: user.errors.full_messages
      debugger
      redirect_to sessions_url
    end
  end

  def new
    render :new
  end

  def show
    render :show
  end

  def destroy
    debugger 
    logout!
    redirect_to users_url
  end

end
