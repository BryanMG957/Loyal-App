require 'rails_helper'

RSpec.describe "service_types/index", type: :view do
  before(:each) do
    assign(:service_types, [
      ServiceType.create!(
        :name => "Name",
        :price => "Price"
      ),
      ServiceType.create!(
        :name => "Name",
        :price => "Price"
      )
    ])
  end

  it "renders a list of service_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Price".to_s, :count => 2
  end
end
