require 'rails_helper'

describe User::MembersController, :type => :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin_user) {FactoryGirl.create(:admin_user)}
  let(:user_1) {FactoryGirl.create(:user)}
  let(:user_2) {FactoryGirl.create(:user)}

  before(:each) do
    session[:id] = admin_user.id
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      get :show, {:id => user.to_param}
      expect(assigns(:user)).to eq (user)
    end
  end

  describe "GET index" do
    it "assigns all practice as @practise" do
      [user_1, user_2]
      get :index
      expect(assigns[:users]).to match_array([admin_user,user_1, user_2])
    end
  end
end
