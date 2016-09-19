class BillsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_bill, only: [:edit, :update, :destroy, :remove_appt]

  # GET /bills
  # GET /bills.json
  def index
    @bills = policy_scope(Bill).order("id DESC")
  end

  def unbilled
    if (@current_employee.is_superuser?)
      @clients = Client.all
    else
      @clients = @current_employee.company.clients
    end
    if (@current_employee.is_superuser? || (@current_employee.company && @current_employee.is_admin?))
      @clienthash = {}
      @appointments = Appointment.billable_appts(@current_employee.company_id)
      @appointments.each do |appt|
        @clienthash[appt.client_id] = @clienthash.fetch(appt.client_id, 0) + 1
      end
      @bill = Bill.new
    else
      redirect_to '/unauthorized'
    end
  end

  # DELETE /bills/1/remove_appt/1
  def remove_appt
    @item = @items.find_by(id: params[:appt_id])
    if @item
      @item.update_attributes(bill_id: nil)
    end
    redirect_to "/bills/#{params[:id]}/edit"
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @bill = Bill.find(params[:id])
    authorize @bill
  end

  # GET /bills/new
  def new
    @bill = Bill.new
    @bill.date_billed = Time.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)
    respond_to do |format|
      if @bill.save
        # Add appointments to bill
        appt_ids = params["bill"][:appt_ids_to_bill].map { |n|
          appt = Appointment.find_by(id: n)
          if appt
            appt.bill = @bill
            appt.status = "billed"
            appt.save
          end
        }

        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    Appointment.where(bill_id: @bill.id).update_all(bill_id: nil)
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
      authorize @bill
      @items = Appointment.where(bill_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:total_amount, :paid_amount, :date_billed, :date_paid, :discount, :client_id, :appt_ids_to_bill)
    end
end
