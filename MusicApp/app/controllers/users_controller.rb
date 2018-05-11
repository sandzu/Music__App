class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    debugger
    if user.save
      @user = user
      login!(user)
      render json: user
    else
      #render json: user.errors.full_messages
      redirect_to users_url
    end

  end


  def index
    render :index
  end

  def new
    debugger
    render :new
  end

  def show
    # debugger
    render :show
  end



  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
