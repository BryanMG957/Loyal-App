class ServiceTypesController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_service_type, only: [:edit, :update, :destroy]
  before_action :set_company_dropdown, only: [:new, :edit]
  # GET /service_types
  # GET /service_types.json
  def index
    if (@current_employee.is_superuser?)
      @service_types = ServiceType.all 
    elsif (@current_employee.company)
      @service_types = ServiceType.where(company_id: @current_employee.company_id)
    else
      redirect_to '/unauthorized'
    end
  end

  def show
    if (@current_employee.is_superuser? || (@current_employee.is_admin? &&
        (ServiceType.find(params[:id]).company_id == @current_employee.company_id)))
      @service_type = ServiceType.find(params[:id])
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /service_types/1.json
  # GET /service_types/new
  def new
    @service_type = ServiceType.new
  end

  # GET /service_types/1/edit
  def edit
  end

  # POST /service_types
  # POST /service_types.json
  def create
    @service_type = ServiceType.new(service_type_params)

    respond_to do |format|
      if @service_type.save
        format.html { redirect_to @service_type, notice: 'Service type was successfully created.' }
        format.json { render :show, status: :created, location: @service_type }
      else
        format.html { render :new }
        format.json { render json: @service_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_types/1
  # PATCH/PUT /service_types/1.json
  def update
    respond_to do |format|
      if @service_type.update(service_type_params)
        format.html { redirect_to @service_type, notice: 'Service type was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_type }
      else
        format.html { render :edit }
        format.json { render json: @service_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_types/1
  # DELETE /service_types/1.json
  def destroy
    @service_type.destroy
    respond_to do |format|
      format.html { redirect_to service_types_url, notice: 'Service type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_type
      if (@current_employee.is_superuser? ||
        (@current_employee.is_admin? && (ServiceType.find(params[:id]).company_id == @current_employee.company_id)))
        @service_type = ServiceType.find(params[:id])
      else
        redirect_to '/unauthorized'
      end
    end
    def set_company_dropdown
      if (@current_employee.is_superuser?)
        @allowed_companies = Company.all
      else
        @allowed_companies = Company.where(id: @current_employee.company_id)
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_type_params
      params.require(:service_type).permit(:name, :price, :company_id, :billing_display_name)
    end
end
