class SessionsController < ApplicationController

  def login
    
  end
  
  def create
    @user = User.find_by(email: params[:email])
    
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      # 🔥 LOGIN BUTTON CHECK
    if params[:commit] == "Login"
      session[:total_login_count] ||= 0
      session[:total_login_count] += 1
    end
      redirect_to dashboard_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :login, status: :unprocessable_entity
    end
    
  end
  
  def destroy
    reset_session
    redirect_to login_path, notice: "Logged out Successfully"
  end

end
