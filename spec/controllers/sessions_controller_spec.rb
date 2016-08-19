require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home_path if logged in" do
      session[:user_id] = Fabricate(:user).id

      get :new
      response.should redirect_to home_path
    end

    it "should render new template if not logged in" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "unsuccessful sign-in" do
      it "should redirect to sign_in_path if not signed in" do
        post :create
        response.should redirect_to sign_in_path
      end

      context "wrong password entered" do
        before do
          user = Fabricate(:user, password: "password", email: "bob@example.com")
          post :create, email: "bob@example.com", password: "thisiswrong!"
        end

        it "should redirect to sign_in_path if given the wrong password" do
          response.should redirect_to sign_in_path
        end

        it "sets the notice" do
          expect(flash[:info]).not_to be_blank
        end

        it "does not put any user in the session" do
          expect(session[:user_id]).to be_nil
        end
      end
    end

    context "successful sign-in" do
      let(:bob) {Fabricate(:user, password: "password", email: "bob@example.com")}
      before do
        bob
        post :create, email: "bob@example.com", password: "password"
      end

      it "should redirect to home_path" do
        response.should redirect_to home_path
      end

      it "should set the session[:user_id]" do
        session[:user_id].should eq(bob.id)
      end

      it "sets the notice" do
        expect(flash[:success]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
    end

    it "should set the session user_id to nil" do
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "should set @current_user to nil" do
      get :destroy
      expect(assigns(:current_user)).to be_nil
    end

    it "should redirect to root_path" do
      get :destroy
      response.should redirect_to root_path
    end

    it "sets the notice" do
      get :destroy
      expect(flash[:info]).not_to be_blank
    end
  end
end