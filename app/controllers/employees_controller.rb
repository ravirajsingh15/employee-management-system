class EmployeesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_employee, only: [:edit, :update, :show, :destory]

  def index
    @q = params[:q]
    @work_type = params[:work_type]

    @employees = Employee.all

    if @q.present?
      @employees = @employees.where(
        "name ILIKE :q OR email ILIKE :q OR department ILIKE :q",
        q: "%#{@q}%"
      )
    end

    if @work_type.present?
      @employees = @employees.where(work_type: @work_type)
    end

    @employees = @employees.order(created_at: :desc).page(params[:page]).per(10)
  end


  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to employees_path, notice: "Employee updated successfully"
    else
      render :edit, status: :unprocessable_entity
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
    redirect_to employees_path, notice: "Employee Delete Sucessfully"
  end

  def show
    @employees = Employee.find(params[:id])
    redirect_to dashboard_path
  end

  def new
    @employee = Employee.new
  end

  def edit
    # debugger
    @employee = Employee.find(params[:id])
  end

  private

  # def set_employee
  #   # debugger
  #   Rails.logger.debug "PARAMS ID => #{params[:id]}"
  #   @employees = Employee.find(params[:id])
  # end

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
