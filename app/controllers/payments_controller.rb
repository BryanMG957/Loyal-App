class PaymentsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_payment, only: [:edit, :update, :destroy]
  before_action :set_client_dropdown, only: [:new, :edit, :update]

  # GET /payments
  # GET /payments.json
  def index
    if (@current_employee.is_superuser?)
      @payments = Payment.all.order("id DESC")
    elsif (@current_employee.company)
      clients = Client.where(company_id: @current_employee.company_id).map { |rec| rec.id }
      @payments = Payment.where(client_id: clients).order("id DESC")
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    if (@current_employee.is_superuser? || (@current_employee.is_admin? &&
        (Payment.find(params[:id]).client.company_id == @current_employee.company_id)))
      @payment = Payment.find(params[:id])
    else
      redirect_to '/unauthorized'
    end
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
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
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
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      if (@current_employee.is_superuser? ||
        (@current_employee.is_admin? && (Payment.find(params[:id]).client.company_id == @current_employee.company_id)))
        @payment = Payment.find(params[:id])
      else
        redirect_to '/unauthorized'
      end
    end

    def set_client_dropdown
      if (@current_employee.is_superuser?)
        @clients = Client.all
      else
        @clients = Client.where(company: @current_employee.company)
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:date_received, :amount, :payment_type, :memo, :ref, :client_id)
    end
end
