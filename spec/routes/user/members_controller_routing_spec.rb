require "rails_helper"

describe User::MembersController, :type => :controller do
  it "index" do
    expect(:get => "/user/members").to route_to(
      :controller => "user/members",
      :action => "index"
    )
  end

  it "show" do
    expect(:get => "/user/member/:id").to route_to(
      :controller => "user/members",
      :action => "show",
      :id=> ":id"
    )
  end
end