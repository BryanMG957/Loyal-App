class AppointmentsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_appointment, only: [:edit, :editappt_calendar_window, :update, :destroy]
  before_action :set_client_dropdown, only: [:new, :newappt_calendar_window, :edit, :editappt_calendar_window, :update]
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
    if (@current_employee.is_superuser? || (@current_employee.is_admin? &&
        (Appointment.find(params[:id]).calendar.company_id == @current_employee.company_id)))
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
        notice = "Appointment was successfully created"
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

    # Common calendar API function for icloud and google, with error handler
    # called by create, update and destroy
    # Accepts symbol :create, :update, or :destroy, returns success/error message
    # (to be appended to notice)
    def sync_api(crud_action)
      case @appointment.calendar.apitype
      when "icloud"
        begin
          cal = icloud_connect
          case crud_action
          when :create
            result = cal.create_event(:start => @appointment.start_time.to_s, :end => (@appointment.start_time + 1200).to_s, :title => @appointment.description, :description => @appointment.notes)
            @appointment.uuid = result.properties["uid"]
            @appointment.save
            if result
              return " and added to iCloud calendar #{@appointment.calendar.name}."
            else
              return " locally. Unable to add to iCloud calendar #{@appointment.calendar.name}."
            end
          when :update
            event = cal.find_event(@appointment.uuid)
            cal.delete_event(@appointment.uuid)
            newevent = cal.create_event(:start => @appointment.start_time.to_s, :end => (@appointment.start_time + 1200).to_s, :title => @appointment.description, :description => @appointment.notes)
            @appointment.uuid = newevent.properties["uid"]
            @appointment.save
            if newevent
              return " and updated on iCloud calendar #{@appointment.calendar.name}."
            else
              return " locally. Unable to update iCloud calendar #{@appointment.calendar.name}."
            end
          when :destroy
            cal.delete_event(@appointment.uuid)
            return " and removed from iCloud calendar."
          end
        rescue CalDAViCloud::NotExistError
          return ". Calendar not found in iCloud."
        rescue CalDAViCloud::AuthenticationError
          return ". Calendar not authorized in iCloud."
        rescue CalDAViCloud::DuplicateError
          return " locally. Duplicate item found in iCloud, could not schedule."
        rescue
          return " locally. Could not update iCloud."
        end
      when ""
        return " in the local calendar."
      when "none"
        return " in the local calendar."
      else
        return " locally. Calendar API #{@appointment.calendar.apitype} not yet implemented."
      end
    end

    def set_appointment
      if (@current_employee.is_superuser? ||
        (@current_employee.is_admin? && (Appointment.find(params[:id]).calendar.company_id == @current_employee.company_id)))
        @appointment = Appointment.find(params[:id])
      else
        redirect_to '/unauthorized'
      end
    end
    # Populate dropdown box for setting appointment's client
    def set_client_dropdown
      if (@current_employee.is_superuser?)
        @clients = Client.all
      else
        @clients = Client.where(company: @current_employee.company)
      end
    end
    # iCloud connection function
    def icloud_connect
      servernum = sprintf("%02d", rand(1..24))
      url = "https://p#{servernum}-caldav.icloud.com#{@appointment.calendar.url}"
      CalDAViCloud::Client.new(:uri => url, :user => @appointment.calendar.username , :password => @appointment.calendar.password)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:service, :start_time, :end_time, :charge, :description, :reminder_before, :reminder_after, :status, :notes, :calendar_id, :client_id, :bill_id, :employee_id, :new_date)
    end
end
