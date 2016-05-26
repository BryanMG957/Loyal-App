class HomesController < ApplicationController
  def index
  end
  def calendarmain
  	@appointments = Appointment.all
  	render 'calendarmain'
  end
end
