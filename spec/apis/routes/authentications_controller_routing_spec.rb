require "rails_helper"

RSpec.describe Api::V1::AuthenticationsController, :type => :controller do
  describe "routing" do

    it "routes /api/v1/id/sign_in to the api/v1/sign_in controller and create action" do
      { :post => "/api/v1/sign_in" }.should route_to(:controller => "api/v1/authentications", :action => "create")
    end

    it "routes /api/v1/id/sign_in to the api/v1/sign_in controller and create action" do
      { :delete => "/api/v1/sign_out" }.should route_to(:controller => "api/v1/authentications", :action => "destroy")
    end

  end
end