require "rails_helper"

describe User::DashboardController, :type => :controller do
  it "index" do
    expect(:get => "/user/dashboard").to route_to(
      :controller => "user/dashboard",
      :action => "index"
    )
  end
end