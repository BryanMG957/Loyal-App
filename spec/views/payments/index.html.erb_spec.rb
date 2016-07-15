require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  before(:each) do
    assign(:payments, [
      Payment.create!(
        :amount => "9.99",
        :type => "Type",
        :ref => "Ref",
        :client => nil
      ),
      Payment.create!(
        :amount => "9.99",
        :type => "Type",
        :ref => "Ref",
        :client => nil
      )
    ])
  end

  it "renders a list of payments" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Ref".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
