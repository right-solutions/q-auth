require 'rails_helper'

describe Admin::UsersController, :type => :controller do

  let(:designation) {FactoryGirl.create(:designation, :title => "senior Developer")}
  let(:department) {FactoryGirl.create(:department, :name => "testing")}
  let(:user) {FactoryGirl.create(:user)}
  let(:admin_user) {FactoryGirl.create(:admin_user)}
  let(:user_1) {FactoryGirl.create(:user)}
  let(:user_2) {FactoryGirl.create(:user)}

  before(:each) do
    session[:id] = admin_user.id
  end

  describe "POST create" do

    it "should create user" do
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
     post :create, user_params
     expect(User.count).to  eq 2
   end
 end

 describe "GET show" do
  it "assigns the requested user as @user" do
    get :show, {:id => user.to_param}
    expect(assigns(:user)).to eq (user)
  end
end

describe "PUT update" do
  it "assigns the requested user as @user" do
   put :update, {:id => user.to_param, :user => {"name" => "Raghu",
     "username" => "Raghavendre","email" => "adam@trimediatlantic.com","phone" => "333-093-3334","password" => ConfigCenter::Defaults::PASSWORD,"password_confirmation" => ConfigCenter::Defaults::PASSWORD,"designation_overridden" => "alert","linkedin" => "RaviShankar","skype" => "RaviShankar","status" => "pending","department_id" => department.id,
     "designation_id" => designation.id}}
     expect(assigns(:user)).to eq (user)
   end
 end

 describe "GET edit" do
  it "assigns the requested user as @user" do
    get :edit, {:id => user.to_param}
    expect(assigns(:user)).to eq (user)
  end
end

describe "DELETE destroy" do
  it "destroys the requested user" do
    expect do
      delete :destroy, {:id => user.to_param}
      expect(User.count).to  eq 1
    end
  end
end


describe "GET index" do
  it "assigns all practice as @practise" do
    [designation,user_1, user_2]
    get :index
    expect(assigns[:users]).to match_array([admin_user,user_1, user_2])
  end
end

it "GET make_admin" do
  get :make_admin, {:user_id => user.id.to_s}
    expect(assigns(:user)).to eq (user)
end

it "GET make_super_admin" do
  get :make_super_admin, {:user_id => user.id.to_s}
    expect(assigns(:user)).to eq (user)
end

it "GET remove_admin" do
  get :remove_admin, {:user_id => user.id.to_s}
    expect(assigns(:user)).to eq (user)
end

it "GET remove_super_admin" do
  get :remove_super_admin, {:user_id => user.id.to_s}
    expect(assigns(:user)).to eq (user)
end

end
