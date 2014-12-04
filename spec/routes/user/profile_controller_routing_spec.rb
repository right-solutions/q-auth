require "spec_helper"

describe User::SettingsController, :type => :controller do
  describe "routing" do

    it "routes /user/profile to the user/profile controller and index action" do
      { :get => "user/profile" }.should route_to(:controller => "user/profile", :action => "index")
    end

    it "routes /user/profile to the user/profile controller and edit action" do
      { :get => "user/edit" }.should route_to(:controller => "user/profile", :action => "edit")
    end

  end
end