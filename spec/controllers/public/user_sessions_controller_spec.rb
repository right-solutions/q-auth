require 'rails_helper'

describe Public::UserSessionsController, :type => :controller do

  let(:user1){FactoryGirl.create(:user, :email => 'user1@domain.com', :status => 'approved', :password => "Password@1", :password_confirmation => "Password@1")}
  let(:user2) {FactoryGirl.create(:user, :email => 'user2@domain.com', :status => 'pending', :password => "Password@1", :password_confirmation => "Password@1")}

  describe "create a session" do

    describe "positive case" do
      it "should create session" do
        sign_in_params = {
          email: user1.email,
          password: user1.password
        }
        session[:id] = nil
        post :create_session, sign_in_params
        expect(session[:id]).not_to be_nil
      end
    end

    describe "negative case" do
      it "should fail to create session" do
        sign_in_params = {
          email: user2.email,
          password: "Invalid"
        }
        session[:id] = nil
        post :create_session, sign_in_params
        expect(session[:id]).to be_nil
      end
    end
  end

  describe "destroy a session" do
    it "should delete session of user" do
      session[:id] = user1.id
      delete :sign_out, :id => user1.id
      expect(session[:id]).to be_nil
    end
  end
end
