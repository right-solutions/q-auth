require 'rails_helper'

describe Admin::DepartmentsController, :type => :controller do

  let(:super_admin_user) {FactoryGirl.create(:super_admin_user)}
  let(:department1) {FactoryGirl.create(:department)}
  let(:department2) {FactoryGirl.create(:department)}

  it "assigns all departments as @departments" do
    [department1,department2]
    get :index, nil, {id: super_admin_user.id}
    expect(assigns[:departments]).to match_array([department1,department2])
  end

  it "GET #show" do
    get :show, {:id => department1.id}, {id: super_admin_user.id}
    expect(assigns(:department)).to eq(department1)
  end

  it "POST #create" do
    department_params = {
      department: {
        name: "User",
        description: "Test Data"
      }
    }
    post :create, department_params, {id: super_admin_user.id}
    expect(Department.count).to  eq 1
  end

  it "GET #edit" do
    get :edit, {:id => department1.id}, {id: super_admin_user.id}
    expect(assigns[:department]).to eq(department1)
  end

  it "assigns the requested department as @department" do
    put :update, {:id => department1.to_param, :department => {:name =>"dep name", :description =>"updated test data"}}, {id: super_admin_user.id}
    expect(assigns(:department)).to eq(department1)
  end

  it "destroys the requested department" do
    [department1, department2]
    expect do
      delete :destroy, {:id => department2.id}, {id: super_admin_user.id}
    end.to change(Department, :count).by(-1)
  end

end