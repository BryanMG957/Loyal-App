class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit
  include AppointmentsHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  attr_reader :current_user

  private

  def logged_in_using_omniauth?
    if (session[:userinfo].present? || Rails.env == "test")
      @current_employee = Employee.find_by(id: session[:userinfo][:employee])
      @current_user = @current_employee
    else
      # Redirect to page that has the login here
      redirect_to '/'
      false
    end
  end

  def user_not_authorized
    redirect_to '/unauthorized'
  end
end
