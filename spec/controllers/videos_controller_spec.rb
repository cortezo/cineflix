require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "should render the show template" do
      bob = User.create(email: "bob@bob.com", full_name: "Bob McBobicus", password: "password")
      session[:user_id] = bob.id
      
      get :show
      response.should render_template :show
    end
  end

  describe "GET search" do
    it "should return an empty array @results if there are no matches"
    it "should return an array of videos in @results if results are found"
    it "should render the search_results partial" do
      bob = User.create(email: "bob@bob.com", full_name: "Bob McBobicus", password: "password")
      session[:user_id] = bob.id

      get :search
      response.should render_template :search_results
    end
  end
end