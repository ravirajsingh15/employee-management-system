class EmployeesController < ApplicationController
  before_action :set_employee, only: [:edit, :update, :show, :destory]
  def index 
    @employees = Employee.all.order(:name)
  end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: "Employee updated successfully"
    else
      render :edit
    end
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: "Employee Created Sucessfully"
    else
      render :new
    end
  end

  def destroy
    @employee&.destroy
    redirect_to employees_path, notice: "Employeeeee1 Delete Sucessfully"
  end

  def show
    @employees = Employee.find(params[:id])
    redirect_to dashboard_path
  end

  def new
    @employees = Employee.new
  end

  private

  def set_employee
    # debugger
    Rails.logger.debug "PARAMS ID => #{params[:id]}"
    @employees = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(
      :name,
      :email,
      :work_type,
      :phone,
      :address,
      :last_active,
      :department,
      :designation,
      :salary,
      :joining_date
    )
  end

end
