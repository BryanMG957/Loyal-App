class EmployeePolicy < ApplicationPolicy
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
        scope.where(company_id: user.company_id)
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  attr_reader :user, :employee

  def initialize(user, employee)
    @user = user
    @employee = employee
  end

  def show?
    user.is_superuser? || (user.company == employee.company)
  end

  def edit?
    user.is_superuser? || (user.company == employee.company && user.is_admin?)
  end
  alias :update? :edit?
  alias :destroy? :edit?
end
