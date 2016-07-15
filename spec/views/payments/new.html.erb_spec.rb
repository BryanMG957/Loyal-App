require 'rails_helper'

RSpec.describe "payments/new", type: :view do
  before(:each) do
    assign(:payment, Payment.new(
      :amount => "9.99",
      :type => "",
      :ref => "MyString",
      :client => nil
    ))
  end

  it "renders new payment form" do
    render

    assert_select "form[action=?][method=?]", payments_path, "post" do

      assert_select "input#payment_amount[name=?]", "payment[amount]"

      assert_select "input#payment_type[name=?]", "payment[type]"

      assert_select "input#payment_ref[name=?]", "payment[ref]"

      assert_select "input#payment_client_id[name=?]", "payment[client_id]"
    end
  end
end
