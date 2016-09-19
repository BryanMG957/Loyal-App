class ServiceTypePolicy < ApplicationPolicy
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

  attr_reader :user, :service_type

  def initialize(user, service_type)
    @user = user
    @service_type = service_type
  end

  def show?
    user.is_superuser? || (user.company == service_type.company)
  end

  def edit?
    user.is_superuser? || (user.company == service_type.company && user.is_admin?)
  end
  alias :update? :edit?
  alias :destroy? :edit?
end
