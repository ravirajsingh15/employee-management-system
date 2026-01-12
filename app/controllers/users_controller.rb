class UsersController < ApplicationController
  def signup
    @user = User.new
  end

  def create
    # debugger
    @user = User.new(user_params)
    UserMailer.signup_email(@user).deliver_now
    if @user.country_iso.present?
      country = ISO3166::Country[@user.country_iso] || "IN"

      if country
        dial_code = country.country_code.is_a?(Array) ? country.country_code.first : country.country_code
        @user.country_code = "+#{dial_code}"
        @user.country      = country.translations['en'] || country.name
      end
    end

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      render :signup, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
    :name, 
    :email, 
    :password, 
    :phone_no, 
    :country_code, 
    :country_iso,
    :country)
  end
  
end
 