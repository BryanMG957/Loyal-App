class EmployeesController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_employee, only: [:edit, :update, :destroy]
  before_action :set_dropdown, only: [:new, :edit]
  # GET /employees
  # GET /employees.json
  def index
    if (@current_employee.is_superuser?)
      @employees = Employee.all.order("last_name")
    else
      @employees = Employee.where(company_id: @current_employee.company_id).order("last_name")
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    if (@current_employee.is_superuser? ||
        (Employee.find(params[:id]).company_id == @current_employee.company_id))
      @employee = Employee.find(params[:id])
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    Appointment.where(employee: @employee).update_all(employee: nil)
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      if (@current_employee.is_superuser? ||
        (@current_employee.is_admin? && (Employee.find(params[:id]).company_id == @current_employee.company_id)))
        @employee = Employee.find(params[:id])
      else
        redirect_to '/unauthorized'
      end
    end
    # Populate dropdown box for setting employee's company
    def set_dropdown
      if (@current_employee.is_superuser?)
        @allowed_companies = Company.all
      else
        @allowed_companies = Company.where(id: @current_employee.company_id)
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :username, :password, :company_id)
    end
end
