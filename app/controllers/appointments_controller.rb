class AppointmentsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_appointment, only: [:edit, :editappt_calendar_window, :update, :destroy]
  before_action :set_client_dropdown, only: [:new, :newappt_calendar_window, :edit, :editappt_calendar_window, :update]
  before_action :set_calendar_dropdown, only: [:new, :newappt_calendar_window, :edit, :editappt_calendar_window, :update]
  before_action :set_service_type_dropdown, only: [:new, :newappt_calendar_window, :edit, :editappt_calendar_window, :update]

  # GET /appointments
  # GET /appointments.json
  def index
    if (@current_employee.is_superuser?)
      @appointments = Appointment.all.order("start_time DESC")
    elsif (@current_employee.company)
      calendars = Calendar.where(company_id: @current_employee.company_id).map { |rec| rec.id }
      @appointments = Appointment.where(calendar_id: calendars).order("start_time DESC")
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    if (@current_employee.is_superuser?)
      @appointment = Appointment.find(params[:id])
    elsif (@current_employee.is_admin? &&
        (Appointment.find(params[:id]).calendar.company_id == @current_employee.company_id))
      @appointment = Appointment.find(params[:id])
    else
      redirect_to '/unauthorized'
    end
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/newappt_calendar_window
  # used to render 'New Appointment' as a sidebar on calendarmain
  def newappt_calendar_window
    @appointment = Appointment.new
    if params[:new_date]
      @appointment.start_time = DateTime.parse(params[:new_date])
      @appointment.end_time = DateTime.parse(params[:new_date]) + (1.0/24/2)
    end
    render 'new', layout: "calendarsidebar"
  end

  # GET /appointments/1/edit
  def edit
  end

  # GET /appointments/:id/editappt_calendar_window
  # used to render 'Edit Appointment' as a sidebar on calendarmain
  def editappt_calendar_window
    render 'edit', params: {id: params[:id]}, layout: "calendarsidebar"
  end

  # POST /appointments
  # POST /appointments.json
  def create
    appointment_params[:start_time] = DateTime.parse(appointment_params[:start_time])
    appointment_params[:end_time] = DateTime.parse(appointment_params[:end_time])
    @appointment = Appointment.new(appointment_params)
    respond_to do |format|
      if @appointment.save
        notice = "Appointment was created"
        notice += sync_api(:create)
        format.html { redirect_to @appointment, notice: notice }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    appointment_params[:start_time] = DateTime.parse(appointment_params[:start_time])
    appointment_params[:end_time] = DateTime.parse(appointment_params[:end_time])
    respond_to do |format|
      if @appointment.update(appointment_params)
        notice = "Appointment was successfully updated"
        notice += sync_api(:update)
        format.html { redirect_to @appointment, notice: notice }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    notice = "Appointment was successfully deleted"
    notice += sync_api(:destroy)
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def sync_api(crud_action)
      return CalendarAPI::call(crud_action, @appointment)
    end

    def set_appointment
      if (@current_employee.is_superuser? ||
        (@current_employee.is_admin? && (Appointment.find(params[:id]).calendar.company_id == @current_employee.company_id)))
        @appointment = Appointment.find(params[:id])
      else
        redirect_to '/unauthorized'
      end
    end
    # Populate dropdown box for setting appointment's calendar
    def set_calendar_dropdown
      if (@current_employee.is_superuser?)
        @calendars = Calendar.all
      else
        @calendars = Calendar.where(company: @current_employee.company)
      end
    end
    # Populate dropdown box for setting appointment's client
    def set_client_dropdown
      if (@current_employee.is_superuser?)
        @clients = Client.all.includes(:pets)
      else
        @clients = Client.where(company: @current_employee.company).includes(:pets)
      end
    end
    def set_service_type_dropdown
      if (@current_employee.is_superuser?)
        @service_types = ServiceType.all
      else
        @service_types = ServiceType.where(company: @current_employee.company)
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:service, :start_time, :end_time, :charge, :description, :reminder_before, :reminder_after, :status, :notes, :calendar_id, :client_id, :bill_id, :employee_id, :new_date)
    end
end
