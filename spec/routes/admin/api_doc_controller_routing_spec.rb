require "rails_helper"

describe Admin::ApiDocController, :type => :controller do
  it "index" do
    expect(:get => "/admin/api_doc").to route_to(
      :controller => "admin/api_doc",
      :action => "index"
    )
  end
end