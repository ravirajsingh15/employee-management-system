class DailyActivitiesController < ApplicationController

   before_action :authenticate_user!
   
  require 'csv'
  def index
    # @daily_activities = filtered_activities
    # ================= FILTER PARAMS =================
    selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    work_type     = params[:work_type]

    # ================= BASE QUERY =================
    activities = DailyActivity.includes(:employee)
                              .where(activity_date: selected_date)

    activities = activities.where(work_type: work_type) if work_type.present?

    @daily_activities = activities.order(:login_at)

    # ================= COUNTS FOR GAUGE / DONUT =================
    @total_wfo        = activities.where(work_type: "wfo").count
    @total_wfh        = activities.where(work_type: "wfh").count
    @total_noworking  = activities.where(work_type: "no-working").count

    @total_employees  = Employee.count
    @total_employees_count = DailyActivity.includes(:employee)
                              .where(activity_date: selected_date).count
  end

  def export_csv
    activities = filter_activities
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["Sr NO", "Employee Name", "Work Type", "Login", "Logout", "Remarks"]

      activities.each_with_index do |activity, index|
        csv << [
          index + 1,
          activity.employee.name,
          activity.work_type,
          activity.login_at,
          activity.logout_at,
          activity.remarks
        ]
      end
    end
    send_data csv_data, filename:"daily_activities_#{params[:activity_date] || Date.today}.csv"
    # ReportMailer.send_csv(curret_user.email, csv_data).deliver_now
    # flash[:alert] = "CSV Downloaded and send email sucessfully"
  end

  def new
    @daily_activities = DailyActivity.new
    @employee = Employee.order(:name)
  end

  def create
    @daily_activities = DailyActivity.new(daily_activities_params)
    @daily_activities.user = current_user
    @daily_activities.activity_date = Date.today
    @daily_activities.login_at = Time.current

    if @daily_activities.save
      redirect_to daily_activities_path, notice: "Activity Marked Successfully"
    else
      @employee = Employee.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def filter_activities
    # debugger
    activities = DailyActivity.includes(:employee)

    if params[:activity_date].present?
      activities = activities.where(activity_date: params[:activity_date])
    end

    activities.order(created_at: :asc)
  end

  def daily_activities_params
    params.require(:daily_activities).permit(
      :employee_id,
      :remarks,
      :work_type
    )
  end
end
