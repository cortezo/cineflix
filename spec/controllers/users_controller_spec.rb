require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user record" do
        User.first.should be_instance_of(User)
      end

      it "redirects to the sign_in_path" do
        response.should redirect_to sign_in_path
      end
    end

    context "input is invalid" do
      before do
        post :create, user: Fabricate.attributes_for(:user, email: nil)
      end

      it "does not create a user" do
        User.first.should be_nil
      end

      it "renders the :new template" do
        response.should render_template :new
      end

      it "sets the @user variable" do
        assigns(:user).should be_instance_of(User)
      end
    end
  end
end  