class CompanyPolicy < ApplicationPolicy
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
        scope.where(id: user.company_id)
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  attr_reader :user, :company

  def initialize(user, company)
    @user = user
    @company = company
  end

  def new?
    user.is_superuser?
  end

  def show?
    user.is_superuser? || (user.company == company)
  end

  def edit?
    user.is_superuser? || (user.company == company && user.is_admin?)
  end
  alias :update? :edit?
  alias :destroy? :edit?
end
