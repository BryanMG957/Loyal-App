require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appointments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appointment" do
    assert_difference('Appointment.count') do
      post :create, appointment: { bill_id: @appointment.bill_id, calendar_id: @appointment.calendar_id, charge: @appointment.charge, client_id: @appointment.client_id, employee_id: @appointment.employee_id, end_time: @appointment.end_time, notes: @appointment.notes, reminder_after: @appointment.reminder_after, reminder_before: @appointment.reminder_before, start_time: @appointment.start_time, status: @appointment.status, type: @appointment.type }
    end

    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should show appointment" do
    get :show, id: @appointment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appointment
    assert_response :success
  end

  test "should update appointment" do
    patch :update, id: @appointment, appointment: { bill_id: @appointment.bill_id, calendar_id: @appointment.calendar_id, charge: @appointment.charge, client_id: @appointment.client_id, employee_id: @appointment.employee_id, end_time: @appointment.end_time, notes: @appointment.notes, reminder_after: @appointment.reminder_after, reminder_before: @appointment.reminder_before, start_time: @appointment.start_time, status: @appointment.status, type: @appointment.type }
    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should destroy appointment" do
    assert_difference('Appointment.count', -1) do
      delete :destroy, id: @appointment
    end

    assert_redirected_to appointments_path
  end
end
