require 'rails_helper'

RSpec.describe "payments/edit", type: :view do
  before(:each) do
    @payment = assign(:payment, Payment.create!(
      :amount => "9.99",
      :type => "",
      :ref => "MyString",
      :client => nil
    ))
  end

  it "renders the edit payment form" do
    render

    assert_select "form[action=?][method=?]", payment_path(@payment), "post" do

      assert_select "input#payment_amount[name=?]", "payment[amount]"

      assert_select "input#payment_type[name=?]", "payment[type]"

      assert_select "input#payment_ref[name=?]", "payment[ref]"

      assert_select "input#payment_client_id[name=?]", "payment[client_id]"
    end
  end
end
