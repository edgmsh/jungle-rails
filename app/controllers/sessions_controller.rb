class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:email], params[:password])

    if user
      # Success logic - user is authenticated, log them in
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      # Failure logic - user is not authenticated, render login form again
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
