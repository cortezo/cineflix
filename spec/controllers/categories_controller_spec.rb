require 'spec_helper'

describe CategoriesController do
  # GET index should do two things.  It should set the @categories variable and it should render a template.  That's it.
  describe "GET index" do
    it "sets the @categories variable" do
      bob = User.create(email: "bob@bob.com", full_name: "Bob McBobicus", password: "password")
      session[:user_id] = bob.id

      action = Category.create(name: "Action")
      drama = Category.create(name: "Drama")

      get :index
      expect(assigns(:categories)).to eq([action, drama])
    end
    it "renders the template" do
      bob = User.create(email: "bob@bob.com", full_name: "Bob McBobicus", password: "password")
      session[:user_id] = bob.id

      get :index
      response.should render_template :index
    end
  end

  # GET show should do one thing.  Render the template.
  describe "GET show" do

  end
  
end