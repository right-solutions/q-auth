require "spec_helper"

describe User::SettingsController, :type => :controller do
  describe "routing" do

    it "routes /user/dashboard to the user/dashboard controller and index action" do
      { :get => "user/settings" }.should route_to(:controller => "user/settings", :action => "index")
    end

  end
end