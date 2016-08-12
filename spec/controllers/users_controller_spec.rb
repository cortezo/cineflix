require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets the @user variable" do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of(User)
    end

    it "renders the new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    it "creates the user record when the input is valid" do
      post :create, user: {email: "bob@bob.com", full_name: "Bob McBobicus", password: "password", password_confirmation: "password"}
      User.first.email.should == "bob@bob.com"
      User.first.full_name.should == "Bob McBobicus"
    end

    it "redirects to the sign_in_path when the input is valid" do
      post :create, user: {email: "bob@bob.com", full_name: "Bob McBobicus", password: "password", password_confirmation: "password"}
      response.should redirect_to sign_in_path
    end

    it "renders the :new template when the input is invalid" do
      bob1 = User.create(email: "bob@bob.com", full_name: "Bob One", password: "password1")
      post :create, user: {email: "bob@bob.com", full_name: "Bob Two", password: "password2", password_confirmation: "password"}
      
      response.should render_template :new
    end

    it "does not create a user when input is invalid" do
      bob1 = User.create(email: "bob@bob.com", full_name: "Bob One", password: "password1")
      post :create, user: {email: "bob@bob.com", full_name: "Bob Two", password: "password2", password_confirmation: "password"}
      
      User.find_by(full_name: "Bob Two").should_not be
    end
  end
end  