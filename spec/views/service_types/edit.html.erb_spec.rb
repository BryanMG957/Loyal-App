require 'rails_helper'

RSpec.describe "service_types/edit", type: :view do
  before(:each) do
    @service_type = assign(:service_type, ServiceType.create!(
      :name => "MyString",
      :price => "MyString"
    ))
  end

  it "renders the edit service_type form" do
    render

    assert_select "form[action=?][method=?]", service_type_path(@service_type), "post" do

      assert_select "input#service_type_name[name=?]", "service_type[name]"

      assert_select "input#service_type_price[name=?]", "service_type[price]"
    end
  end
end
