require "rails_helper"

describe Api::V1::DepartmentsController, :type => :controller do
  it "index" do
    expect(:get => "/api/v1/departments").to route_to(
      :controller => "api/v1/departments",
      :action => "index"
    )
  end



end
