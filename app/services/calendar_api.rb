# Common calendar API function for icloud and google, with error handler
# called by create, update and destroy
# Accepts symbol :create, :update, or :destroy, returns success/error message
# (to be appended to notice)

class CalendarAPI
  attr_reader :crud_action
  attr_reader :appointment
  attr_reader :apitype

  def initialize(crud_action, appointment)
    @crud_action = crud_action
    @appointment = appointment
    @apitype = appointment.calendar.apitype
  end

  def self.call(crud_action, appointment)
    if !appointment.calendar
      return "Calendar does not exist."
    else
      self.new(crud_action, appointment).call
    end
  end

  def call
    if apitype == "icloud"
      return icloud_do_api
    elsif apitype == "none"
      return ""
    else
      return ". Appointment added locally. Calendar API #{apitype} not yet implemented."
    end
  end

  def icloud_do_api
    begin
      cal = icloud_connect
      case crud_action
      when :create
        result = cal.create_event(:start => @appointment.start_time.to_s, :end => (@appointment.start_time + 1200).to_s, :title => @appointment.description, :description => @appointment.notes, :reminder_before => @appointment.reminder_before)
        @appointment.uuid = result.uid #.properties["uid"]
        @appointment.save
        if result
          return " and added to iCloud calendar #{@appointment.calendar.name}."
        else
          return " locally. Unable to add to iCloud calendar #{@appointment.calendar.name}."
        end
      when :update
        event = cal.find_event(@appointment.uuid)
        cal.delete_event(@appointment.uuid)
        newevent = cal.create_event(:start => @appointment.start_time.to_s, :end => (@appointment.start_time + 1200).to_s, :title => @appointment.description, :description => @appointment.notes, :reminder_before => @appointment.reminder_before)
        @appointment.uuid = newevent.uid #.properties["uid"]
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
    # rescue
    #   return " locally. Could not update iCloud."
    end
  end

  private

  # iCloud connection function
  def icloud_connect
    servernum = sprintf("%02d", rand(1..24))
    url = "https://p#{servernum}-caldav.icloud.com#{@appointment.calendar.url}"
    CalDAViCloud::Client.new(:uri => url, :user => @appointment.calendar.username , :password => @appointment.calendar.password)
  end
end
