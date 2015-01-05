require 'rails_helper'

describe Admin::UsersController, :type => :controller do

  let(:department) {FactoryGirl.create(:department)}
  let(:designation) {FactoryGirl.create(:designation)}
  let(:super_admin) {FactoryGirl.create(:super_admin_user)}
  let(:super_admin2) {FactoryGirl.create(:super_admin_user)}
  let(:admin) {FactoryGirl.create(:admin_user)}
  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}

  describe "GET index" do
    it "super admin should be able to view all users" do
      arr = [super_admin, admin, user1, user2]
      get :index, nil, {id: super_admin.id}
      expect(assigns[:users]).to match_array(arr)
    end

    it "admin should be able to view all users" do
      arr = [super_admin, admin, user1, user2]
      get :index, nil, {id: admin.id}
      expect(assigns[:users]).to match_array(arr)
    end
  end

  describe "GET show" do
    it "super admin should be able to view details of a particular user" do
      get :show, {:id => user1.to_param}, {id: super_admin.id}
      expect(assigns(:user)).to eq (user1)
    end

    it "admin should be able to view details of a particular user" do
      get :show, {:id => user1.to_param}, {id: admin.id}
      expect(assigns(:user)).to eq (user1)
    end
  end

  describe "POST create" do
    it "super admin should be able to create user" do
      [super_admin, user1, user2]
      user_params = {
        user: {
          name: "Bob Miller",
          username: "RaviShankar",
          email: "adam@trimediatlantic.com",
          phone: "333-093-3334",
          password: ConfigCenter::Defaults::PASSWORD,
          password_confirmation: ConfigCenter::Defaults::PASSWORD,
          designation_overridden: "alert",
          linkedin: "RaviShankar",
          skype: "RaviShankar",
          status: "pending",
          department_id: department.id,
          designation_id: designation.id
        }
      }
      expect do
        post :create, user_params, {id: super_admin.id}
      end.to change(User, :count).by(1)
    end
  end

  describe "PUT update" do
    it "super admin should be able to update user details" do
      user_params = {"name" => "Raghu",
                    "username" => "Raghavendre",
                    "email" => "adam@trimediatlantic.com",
                    "phone" => "333-093-3334",
                    "password" => ConfigCenter::Defaults::PASSWORD,
                    "password_confirmation" => ConfigCenter::Defaults::PASSWORD,
                    "designation_overridden" => "Some Designation",
                    "linkedin" => "RaviShankar",
                    "skype" => "RaviShankar",
                    "status" => "pending",
                    "department_id" => department.id,
                    "designation_id" => designation.id}
      put :update, {:id => user1.to_param, :user => user_params}, {id: super_admin.id}
      expect(assigns(:user)).to eq (user1)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, {:id => user1.to_param}, {id: super_admin.id}
      expect(assigns(:user)).to eq (user1)
    end
  end

  describe "DELETE destroy" do
    it "super admin should be able to destroy the user" do
      expect do
        delete :destroy, {:id => user1.to_param}, {id: super_admin.id}
        expect(User.count).to  eq 1
      end
    end
  end

  describe "Make admin" do
    it "super admin should be able to upgrade a user to admin" do
      get :make_admin, {:user_id => user1.id}, {id: super_admin.id}
      expect(assigns[:user].user_type).to eq("admin")
    end
  end

  describe "Make super admin" do
    it "super admin should be able to upgdate a user to super admin" do
      get :make_super_admin, {:user_id => user1.id}, {id: super_admin.id}
      expect(assigns[:user].user_type).to eq("super_admin")
    end

    it "super admin should be able to upgdate an admin to super admin" do
      get :make_super_admin, {:user_id => admin.id}, {id: super_admin.id}
      expect(assigns[:user].user_type).to eq("super_admin")
    end
  end

  describe "Get remove admin" do
    it "super admin should be able to downgrade an admin to user" do
      get :remove_admin, {:user_id => admin.id}, {id: super_admin.id}
      expect(assigns[:user].user_type).to eq("user")
    end
  end

  describe "Get remove super admin" do
    it "super admin should be able to downgrade a super admin to admin" do
      get :remove_super_admin, {:user_id => super_admin2.id}, {id: super_admin.id}
      expect(assigns[:user].user_type).to eq("admin")
    end
  end

end
