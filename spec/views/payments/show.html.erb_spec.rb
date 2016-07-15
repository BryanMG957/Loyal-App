require 'rails_helper'

RSpec.describe "payments/show", type: :view do
  before(:each) do
    @payment = assign(:payment, Payment.create!(
      :amount => "9.99",
      :type => "Type",
      :ref => "Ref",
      :client => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Ref/)
    expect(rendered).to match(//)
  end
end
