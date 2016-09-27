require "rails_helper"

RSpec.describe V1::StylesheetsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/v1/stylesheets").to route_to("v1/stylesheets#index")
    end

    it "routes to #show" do
      expect(:get => "/v1/stylesheets/1").to route_to("v1/stylesheets#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/stylesheets").to route_to("v1/stylesheets#create")
    end
  end
end