class BillsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_bill, only: [:edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
    if (@current_employee.is_superuser?)
      @bills = Bill.all.order("id DESC")
    elsif (@current_employee.company)
      clients = Client.where(company_id: @current_employee.company_id).map { |rec| rec.id }
      @bills = Bill.where(client_id: clients).order("id DESC")
    else
      redirect_to '/unauthorized'
    end
  end
  def unbilled
    if (@current_employee.company && @current_employee.is_admin?)
      @clienthash = {}
      @appointments = Appointment.find_by_sql "SELECT * FROM calendars c, appointments a WHERE a.calendar_id = c.id AND c.company_id = #{@current_employee.company_id} AND start_time < '#{Time.now.to_s}' AND bill_id IS NULL ORDER BY start_time"
      @appointments.each do |appt|
        @clienthash[appt.client_id] = @clienthash.fetch(appt.client_id, 0) + 1
      end
      @bill = Bill.new
    else
      redirect_to '/unauthorized'
    end
  end
  # GET /bills/1
  # GET /bills/1.json
  def show
    if (@current_employee.is_superuser? || (@current_employee.is_admin? &&
        (Bill.find(params[:id]).client.company_id == @current_employee.company_id)))
      @bill = Bill.find(params[:id])
    else
      redirect_to '/unauthorized'
    end
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
      if (@current_employee.is_superuser? ||
        (@current_employee.is_admin? && (Bill.find(params[:id]).client.company_id == @current_employee.company_id)))
        @bill = Bill.find(params[:id])
        @items = Appointment.where(bill_id: params[:id])
      else
        redirect_to '/unauthorized'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:total_amount, :paid_amount, :date_billed, :date_paid, :discount, :client_id, :appt_ids_to_bill)
    end
end
