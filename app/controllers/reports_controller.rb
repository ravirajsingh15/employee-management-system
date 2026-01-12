class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reports = User.first.reports.order(created_at: :desc)
  end

  def new
    @report = Report.new
  end

  def show
    @report = User.first.reports.find(params[:id])
    @employees = filter_employees(@report)
  end

  def create
    @report = User.first.reports.build(report_params)

    if @report.save
      redirect_to report_path(@report), notice: "Report generated successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.require(:report).permit(
      :from_date,
      :to_date,
      :department,
      :work_type
    )
  end

  def filter_employees(report)
    employees = Employee.all

    if report.from_date.present? && report.to_date.present?
      employees = employees.where(joining_date: report.from_date..report.to_date)
    end

    employees = employees.where(department: report.department) if report.department.present?
    employees = employees.where(work_type: report.work_type) if report.work_type.present?

    employees
  end
end
