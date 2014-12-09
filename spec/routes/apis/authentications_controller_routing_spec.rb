require "rails_helper"

RSpec.describe Api::V1::AuthenticationsController, :type => :controller do
  it "create" do
    expect(:post => "/api/v1/sign_in").to route_to(
      :controller => "api/v1/authentications",
      :action => "create"
    )
  end

  it "destroy" do
    expect(:delete => "/api/v1/sign_out").to route_to(
      :controller => "api/v1/authentications",
      :action => "destroy"
    )
  end
end