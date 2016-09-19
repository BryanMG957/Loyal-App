class PaymentsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_payment, only: [:edit, :update, :destroy]
  before_action :set_client_dropdown, only: [:new, :edit, :update]

  # GET /payments
  # GET /payments.json
  def index
    @payments = policy_scope(Payment).order("id DESC")
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id])
    authorize @payment
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @payment.date_received = Time.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to "/clients/#{@payment.client.id}/ledger", notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    id = @payment.client.id
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to "/clients/#{id}/ledger", notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
      authorize @payment
    end

    def set_client_dropdown
      @clients = policy_scope(Client)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:date_received, :amount, :payment_type, :memo, :ref, :client_id)
    end
end
