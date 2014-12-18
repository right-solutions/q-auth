require "rails_helper"

describe User::MembersController, :type => :controller do
  it "index" do
    expect(:get => "/user/members").to route_to(
      :controller => "user/members",
      :action => "index"
    )
  end
end