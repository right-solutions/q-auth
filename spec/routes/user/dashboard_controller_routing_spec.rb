require "spec_helper"

describe User::DashboardController, :type => :controller do
  describe "routing" do

    it "routes /admin/home to the admin/home controller and index action" do
      { :get => "user/dashboard" }.should route_to(:controller => "user/dashboard", :action => "index")
    end

  end
end