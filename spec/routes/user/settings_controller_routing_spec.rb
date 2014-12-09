require "rails_helper"

describe User::SettingsController, :type => :controller do
  it "index" do
    expect(:get => "/user/settings").to route_to(
      :controller => "user/settings",
      :action => "index"
    )
  end
end