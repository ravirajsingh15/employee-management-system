class DashboardController < ApplicationController

  before_action :authenticate_user!, only: [:index]
  def index
    @total_signups = User.count
    @total_employees = Employee.all.count
    @total_wfo = Employee.wfo.count
    @total_wfh = Employee.wfh.count
    @total_noworking = Employee.no_working.count
    # render :index
  end
end
