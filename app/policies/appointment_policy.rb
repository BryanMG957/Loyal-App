class AppointmentPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_superuser?
        scope.all
      elsif user.company
        scope.joins(:calendar).where(calendars: { company_id: user.company_id })
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  attr_reader :user, :appointment

  def initialize(user, appointment)
    @user = user
    @appointment = appointment
  end

  def show?
    user.is_superuser? || (user.company == appointment.calendar.company && user.is_admin?)
  end
  alias :edit? :show?
  alias :editappt_calendar_window? :show?
  alias :update? :show?
  alias :destroy? :show?
end
