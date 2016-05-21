class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  # before_action :logged_in_using_omniauth?

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        notice = "Appointment was successfully created"
        case @appointment.calendar.apitype
        when "icloud"
          cal = icloud_connect
          result = cal.create_event(:start => @appointment.start_time.to_s, :end => (@appointment.start_time + 1200).to_s, :title => @appointment.description, :description => @appointment.notes)
          @appointment.uuid = result.properties["uid"]
          @appointment.save
          if result
            notice += " and added to iCloud calendar #{@appointment.calendar.name}."
          else
            notice += ". Unable to add to iCloud calendar #{@appointment.calendar.name}."
          end
        when ""
          notice += " in the local calendar."
        else
          notice += " locally. Calendar API #{@appointment.calendar.apitype} not yet implemented."
        end

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
    respond_to do |format|
      if @appointment.update(appointment_params)
        notice = "Appointment was successfully updated."
        case @appointment.calendar.apitype
        when "icloud"
          begin
            cal = icloud_connect
            event = {:start => @appointment.start_time.to_s, :end => (@appointment.start_time + 1200).to_s, :title => @appointment.description, :description => @appointment.notes}
            # set UUID 
            event[:uid] = @appointment.uuid
            c = cal.update_event(event)
          rescue CalDAViCloud::NotExistError
            notice += " Item not found in iCloud."
          end
        end
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
    notice = "Appointment was successfully destroyed."
    case @appointment.calendar.apitype
    when "icloud"
      begin
        cal = icloud_connect
        cal.delete_event(@appointment.uuid)
      rescue CalDAViCloud::NotExistError
        notice += " Item not found in iCloud."
      end
    end
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end
    def icloud_connect
      servernum = sprintf("%02d", rand(1..24))
      url = "https://p#{servernum}-caldav.icloud.com/#{@appointment.calendar.uid}/calendars/#{@appointment.calendar.name}/"
      CalDAViCloud::Client.new(:uri => url, :user => @appointment.calendar.username , :password => @appointment.calendar.password)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:service, :start_time, :end_time, :charge, :description, :reminder_before, :reminder_after, :status, :notes, :calendar_id, :client_id, :bill_id, :employee_id)
    end
end
