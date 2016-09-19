class ClientPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_superuser?
        scope.active
      elsif user.company && user.is_admin?
        scope.active.where(company_id: user.company_id)
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  attr_reader :user, :client

  def initialize(user, client)
    @user = user
    @client = client
  end

  def show?
    user.is_superuser? || (user.company == client.company)
  end

  def edit?
    user.is_superuser? || (user.company == client.company && user.is_admin?)
  end
  alias :update? :edit?
  alias :destroy? :edit?
  alias :ledger? :edit?
end
