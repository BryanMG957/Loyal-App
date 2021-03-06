class HomesController < ApplicationController
  before_action :logged_in_using_omniauth?, only: [:calendarmain]
  def index
  end

  def calendarmain
    @appointments = policy_scope(Appointment)
  end

  def unauthorized
    render 'unauthorized'
  end
end
