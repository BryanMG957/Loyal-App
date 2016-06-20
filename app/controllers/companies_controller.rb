class CompaniesController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_company, only: [:edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    if (@current_employee.is_superuser?)
      @companies = Company.all
    elsif (@current_employee.company)
      @companies = Company.where(id: @current_employee.company)
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    if ((@current_employee.is_superuser?) || (@current_employee.company_id == params[:id].to_i))
      @company = Company.find(params[:id])
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /companies/new
  def new
    if (@current_employee.is_superuser?)
      @company = Company.new
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    Client.where(company: @company).update_all(company: nil)
    Employee.where(company: @company).update_all(company: nil)
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      # Enforce privileges
      if ((@current_employee.is_superuser?) ||
          ((@current_employee.is_admin?) && (@current_employee.company_id == params[:id].to_i)))
        @company = Company.find(params[:id])
      else
        redirect_to '/unauthorized'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :email, :phone, :website, :description)
    end
end
