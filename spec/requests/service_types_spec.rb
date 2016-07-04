require 'rails_helper'

RSpec.describe "ServiceTypes", type: :request do
  describe "GET /service_types" do
    it "works! (now write some real specs)" do
      get service_types_path
      expect(response).to have_http_status(200)
    end
  end
end
