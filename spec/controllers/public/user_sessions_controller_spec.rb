require 'rails_helper'

describe Public::UserSessionsController, :type => :controller do

  let(:user){FactoryGirl.create(:active_user)}

  describe "create a session" do

    describe "positive case" do
      it "should create session" do
        sign_in_params = {
          email: user.email,
          password: user.password
        }
        post :create_session, sign_in_params
        expect(session[:id].to_s).to  eq(user.id.to_s)
      end
    end

    describe "negative case" do
      it "should fail to create session" do
        sign_in_params = {
          email: user.email,
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
      delete :sign_out, {:id => user.id}, {id: user.id}
      expect(response).to redirect_to("/sign_in?")
    end
  end
end
