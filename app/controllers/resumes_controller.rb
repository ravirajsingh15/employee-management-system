class ResumesController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = curret_user
  end

  def destroy
    curret_user.resume.purge
    redirect_to resume_path, notice: "Resume Delete Sucessfully"
  end

  def update
    @user  = curret_user

    if @user.update(resume_params)
      redirect_to resume_path, notice: "Resume Uploaded Sucessfully"
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :show
    end

  end

  private

  def resume_params
    params.require(:user).permit(:resume)
  end

end
