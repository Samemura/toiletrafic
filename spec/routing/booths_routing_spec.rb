require "rails_helper"

RSpec.describe BoothsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/booths").to route_to("booths#index")
    end

    it "routes to #new" do
      expect(:get => "/booths/new").to route_to("booths#new")
    end

    it "routes to #show" do
      expect(:get => "/booths/1").to route_to("booths#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/booths/1/edit").to route_to("booths#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/booths").to route_to("booths#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/booths/1").to route_to("booths#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/booths/1").to route_to("booths#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/booths/1").to route_to("booths#destroy", :id => "1")
    end

  end
end
