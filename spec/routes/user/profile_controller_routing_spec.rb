require "spec_helper"

describe User::SettingsController, :type => :controller do
  describe "routing" do

    it "routes /user/profile to the user/profile controller and index action" do
      { :get => "user/profile" }.should route_to(:controller => "user/profile", :action => "index")
    end

    it "routes /user/edit to the user/profile controller and edit action" do
      { :get => "user/edit" }.should route_to(:controller => "user/profile", :action => "edit")
    end

    it "routes /user/update to the user/profile controller and update action" do
      { :put => "user/update" }.should route_to(:controller => "user/profile", :action => "update")
    end

  end
end