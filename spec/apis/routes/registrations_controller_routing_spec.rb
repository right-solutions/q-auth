require "spec_helper"

describe Api::V1::RegistrationsController, :type => :controller do
  describe "routing" do

    it "routes /api/v1/id/registrations to the api/v1/registrations controller and create action" do
      { :post => "/api/v1/register" }.should route_to(:controller => "api/v1/registrations", :action => "create")
    end

  end
end