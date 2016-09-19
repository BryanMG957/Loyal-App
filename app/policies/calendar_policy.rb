class CalendarPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_superuser?
        scope.all
      elsif user.company && user.is_admin?
        scope.where(company_id: user.company_id)
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  attr_reader :user, :calendar

  def initialize(user, calendar)
    @user = user
    @calendar = calendar
  end

  def show?
    user.is_superuser? || (user.company == calendar.company && user.is_admin?)
  end
  alias :edit? :show?
  alias :update? :show?
  alias :destroy? :show?
end
