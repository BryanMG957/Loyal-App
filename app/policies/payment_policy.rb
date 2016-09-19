class PaymentPolicy < ApplicationPolicy
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
        scope.joins(:client).where(clients: { company_id: user.company_id })
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  attr_reader :user, :payment

  def initialize(user, payment)
    @user = user
    @payment = payment
  end

  def show?
    user.is_superuser? || (user.company == payment.client.company)
  end

  def edit?
    user.is_superuser? || (user.company == payment.client.company && user.is_admin?)
  end
  alias :update? :edit?
  alias :destroy? :edit?
end
