require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post :create, client: { address: @client.address, company_id: @client.company_id, email: @client.email, first_name: @client.first_name, first_name_2: @client.first_name_2, last_name: @client.last_name, last_name_2: @client.last_name_2, notes: @client.notes, phone1: @client.phone1, phone2: @client.phone2, phone3: @client.phone3, phone4: @client.phone4 }
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    get :show, id: @client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client
    assert_response :success
  end

  test "should update client" do
    patch :update, id: @client, client: { address: @client.address, company_id: @client.company_id, email: @client.email, first_name: @client.first_name, first_name_2: @client.first_name_2, last_name: @client.last_name, last_name_2: @client.last_name_2, notes: @client.notes, phone1: @client.phone1, phone2: @client.phone2, phone3: @client.phone3, phone4: @client.phone4 }
    assert_redirected_to client_path(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, id: @client
    end

    assert_redirected_to clients_path
  end
end
