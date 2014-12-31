require "rails_helper"



describe Admin::UsersController, :type => :controller do
  let(:user) {FactoryGirl.create(:user)}

  it "make admin" do
    expect(:get => admin_user_make_admin_path(user)).to route_to(:action => 'make_admin', :controller => 'admin/users', :user_id => user.id.to_s)
  end

  it "make super admin" do
    expect(:get => admin_user_make_super_admin_path(user)).to route_to(:action => 'make_super_admin', :controller => 'admin/users', :user_id => user.id.to_s)
  end

  it "remove admin" do
    expect(:get => admin_user_remove_admin_path(user)).to route_to(:action => 'remove_admin', :controller => 'admin/users', :user_id => user.id.to_s)
  end

  it "remove super admin" do
    expect(:get => admin_user_remove_super_admin_path(user)).to route_to(:action => 'remove_super_admin', :controller => 'admin/users', :user_id => user.id.to_s)
  end


end