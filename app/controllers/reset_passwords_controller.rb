class ResetPasswordsController < ApplicationController

  def new_password
    
  end

  def create_password
    # debugger
    @user = User.find_by(email: params[:email])
    if @user
      @user.generate_reset_token!
      UserMailer.with(user: @user).reset_password_email.deliver_now
      flash[:notice] = "Reset Link send to your email"
      redirect_to login_path
    else
      flash[:alert] = "Email not found"
      render :new_password
    end
  end

  def edit_password
    @user = User.find_by(reset_password_token: params[:token])
    unless @user && @user.reset_token_valid?
      redirect_to new_password_reset_path, alert: 'Link Expired'
    end
  end

  def update_password
    @user = User.find_by(reset_password_token: params[:token])
    if @user.update(
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
      @user.clear_reset_token!
      redirect_to login_path, notice: "Password updated successfully"
    else
     flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :edit_password
    end
  end


  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
