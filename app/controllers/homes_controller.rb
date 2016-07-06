class HomesController < ApplicationController
  before_action :logged_in_using_omniauth?, only: [:calendarmain]
  def index
  end
  def calendarmain
    if (@current_employee.is_superuser?)
      @appointments = Appointment.all
    elsif (@current_employee.company)
      calendars = Calendar.where(company_id: @current_employee.company_id).map { |rec| rec.id }
      @appointments = Appointment.where(calendar_id: calendars)
    else
      redirect_to '/unauthorized'
    end
  end
  def unauthorized
    render 'unauthorized'
  end
end
