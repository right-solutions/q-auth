require 'rails_helper'

describe Admin::DesignationsController, :type => :controller do

  let(:designation1) {FactoryGirl.create(:designation)}
  let(:designation2) {FactoryGirl.create(:designation)}
  let(:super_admin) {FactoryGirl.create(:super_admin_user, :name => "testuser", :username =>"username", :email =>"abcd@yopmail.com", :biography => "Hi this is lorem ipsum", :password =>  ConfigCenter::Defaults::PASSWORD, :password_confirmation =>  ConfigCenter::Defaults::PASSWORD, :user_type =>"super_admin" )}

  it "assigns all get_collections as @designations" do
    arr = [designation1, designation2]
    get :index, nil, {id: super_admin.id}
    expect(assigns[:designations]).to match_array(arr)
  end

  it "GET #show" do
   get :show, {id: designation1.id}, {id: super_admin.id}
   expect(assigns(:designation)).to eq(designation1)
  end

  it "POST #create" do
    designation_params = {
      designation: {
        title: "Developer",
        responsibilities: "Quality code"
      }
    }
    post :create, designation_params, {id: super_admin.id}
    expect(Designation.count).to  eq 1
  end

  it "GET #edit" do
   get :edit, {id: designation1.id}, {id: super_admin.id}
   expect(assigns[:designation]).to eq(designation1)
  end

  it "assigns the requested designation as @designation" do
    put :update, {:id => designation1.id, :designation => { :title => "New title", :responsibilities =>"Tested data"}}, {id: super_admin.id}
    expect(assigns(:designation)).to eq(designation1)
  end

  it "destroys the requested designation" do
    arr = [designation1, designation2]
    expect do
      delete :destroy, {id: designation1.id}, {id: super_admin.id}
    end.to change(Designation, :count).by(-1)
  end

end