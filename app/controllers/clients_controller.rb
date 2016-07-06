class ClientsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_client, only: [:edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    if (@current_employee.is_superuser?)
      @clients = Client.all.order("last_name")
    elsif (@current_employee.company_id)
      @clients = Client.where(company_id: @current_employee.company_id).order("last_name")
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    if (@current_employee.is_superuser? ||
        (Client.find(params[:id]).company_id == @current_employee.company_id))
      @client = Client.find(params[:id])
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    pets = params[:client].delete(:petlist)
    @client = Client.new(client_params)
    @client.company = @current_employee.company
    pets.each do |petname|
      if (petname != "")
        Pet.create(name: petname, client: @client)
      end
    end

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    pets = params[:client].delete(:petlist)
    # Create any pets not found
    pets.each do |petname|
      if ((petname != "") && !(Pet.find_by(name: petname, client: @client)))
        Pet.create(name: petname, client: @client)
      end
    end
    # Delete any pets that were removed or name changed
    @client.pets.each do |pet|
      unless pets.include? pet.name
        pet.destroy
      end
    end
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    Appointment.where(client: @client).update_all(client: nil)
    Bill.where(client: @client).update_all(client: nil)
    Pet.where(client: @client).destroy_all
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      if (@current_employee.is_superuser? ||
        (@current_employee.is_admin? && (Client.find(params[:id]).company_id == @current_employee.company_id)))
        @client = Client.find(params[:id])
      else
        redirect_to '/unauthorized'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:first_name, :last_name, :email, :phone1, :phone2, :phone3, :phone4, :address, :notes, :company_id, :first_name_2, :last_name_2, :petlist)
    end
end
