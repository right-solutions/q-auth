require "spec_helper"

describe Api::V1::MyProfileController, :type => :controller do
  describe "routing" do

    it "routes /api/v1/id/my_profile to the api/v1/my_profile controller and update action" do
      { :put => "/api/v1/my_profile" }.should route_to(:controller => "api/v1/my_profile", :action => "update")
    end
  end
end