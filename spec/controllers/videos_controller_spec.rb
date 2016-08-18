require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video for authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirects unauthenticated user to root_path" do
      video = Fabricate(:video)
      get :show, id: video.id
      response.should redirect_to root_path
    end

    ### NOTES ###
    ### Don't need to test if it renders Show template, because that is just testing basic rails functionality
    ### and not testing our code.
  end

  describe "GET search" do
    context "authenticated user" do  
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "should return an empty array @results if there are no matches" do
        get :search
        expect(assigns(:results)).to eq([])
      end

      ### NOTES ###
      ### For controller tests we don't need to test all permutations of the search.  That is a model function, 
      ### where the search method resides.  Here we only test Controller functionality.
      it "should return an array of videos in @results if results are found" do
        video = Fabricate(:video, title: "Lost in Translation")

        get :search, search_term: "Translation"
        expect(assigns(:results)).to eq([video])
      end

      ### NOTES ###
      ### Don't need to test if it renders Search template, because that is just testing basic rails functionality
      ### and not testing our code.
    end

    context "unauthenticated user" do
      it "redirects user to root path" do
        get :search
        response.should redirect_to root_path
      end
    end
  end
end