class BillPolicy < ApplicationPolicy
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
        scope.joins(:client).where(clients: { company_id: user.company_id })
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  attr_reader :user, :bill

  def initialize(user, bill)
    @user = user
    @bill = bill
  end

  def show?
    user.is_superuser? || (user.company == bill.client.company && user.is_admin?)
  end
  alias :edit? :show?
  alias :update? :show?
  alias :destroy? :show?
  alias :remove_appt? :show?
end
