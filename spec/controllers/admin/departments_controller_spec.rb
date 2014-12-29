require 'rails_helper'

describe Admin::DepartmentsController, :type => :controller do

  let(:super_admin_user) {FactoryGirl.create(:super_admin_user)}
  let(:admin_user) {FactoryGirl.create(:admin_user)}
  let(:department) {FactoryGirl.create(:department)}
  let(:department_1) {FactoryGirl.create(:department)}
  let(:department_2) {FactoryGirl.create(:department)}


  before(:each) do
    session[:id] = super_admin_user.id
  end

  it "POST #create" do
    department_params = {
      department: {
        name: "User",
        description: "Test Data"
      }
    }
    post :create, department_params
    expect(Department.count).to  eq 1
  end

  it "assigns all departments as @departments" do
    [department_1,department_2]
    get :index
    expect(assigns[:departments]).to match_array([department_1,department_2])
  end

  it "GET #edit" do
    get :edit, {:id => department.id}
    expect(assigns[:department]).to eq(department)
  end

  it "GET #show" do
    get :show, {:id => department.id}
    expect(assigns(:department)).to eq(department)
  end

  it "assigns the requested department as @department" do
    value = department
    put :update, {:id => department.to_param, :department => {:name =>"dep name", :description =>"updated test data"}}
    expect(assigns(:department)).to eq(department)
  end

  it "destroys the requested department" do
    value = department
    expect do
      delete :destroy, {:id => department.id}
    end.to change(Department, :count).by(-1)
  end

end