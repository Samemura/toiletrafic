require 'rails_helper'

RSpec.describe "Booths", type: :request do
  describe "GET /booths" do
    it "works! (now write some real specs)" do
      get booths_path
      expect(response).to have_http_status(200)
    end
  end
end
