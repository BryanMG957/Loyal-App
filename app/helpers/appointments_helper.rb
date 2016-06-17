module AppointmentsHelper
	def displayDate(dt)
		if ((dt.class == DateTime) || (dt.class == Time) || (dt.class == ActiveSupport::TimeWithZone))
			dt.strftime("%b %d %Y - %I:%M %p")
		else
			nil
		end
	end
	def displayDateNoYear(dt)
		if ((dt.class == DateTime) || (dt.class == ActiveSupport::TimeWithZone))
			dt.strftime("%b %d %I:%M%p")
		else
			nil
		end
	end
end
