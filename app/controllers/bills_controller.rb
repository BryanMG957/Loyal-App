class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_using_omniauth?

  # GET /bills
  # GET /bills.json
  def index
    @bills = Bill.all
  end
  def unbilled
    @clienthash = {}
    @appointments = Appointment.where("start_time < '" + Time.now.to_s + "' AND bill_id IS NULL" )
    @appointments.each do |appt|
      @clienthash[appt.client_id] = @clienthash.fetch(appt.client_id, 0) + 1
    end
    @bill = Bill.new
  end
  # GET /bills/1
  # GET /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:total_amount, :paid_amount, :date_billed, :date_paid, :discount, :client_id, :appt_ids_to_bill)
    end
end
