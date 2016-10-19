require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }
    context "without authenticated user" do
      before do
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
      end

      it "redirects unauthenticated user to root path" do
        response.should redirect_to sign_in_path
      end

      it "should not create the review object" do
        expect(video.reviews).to eq([])
      end
    end

    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      context "with valid inputs" do
        before do
          session[:user_id] = current_user.id
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "creates the review associated with the video" do
          video.reviews.first.should be_instance_of(Review)
        end

        it "creates the review associated with the signed in user" do
          expect(Review.first.user).to eq(current_user)
        end

        it "redirects to the video show page" do
          response.should redirect_to video
        end
      end
      
      context "with invalid inputs" do
        before do
          session[:user_id] = Fabricate(:user).id
        end

        it "doesn't create the review object" do
          post :create, review: { rating: 6, body: "blah blah" }, video_id: video.id

          expect(Review.count).to eq(0)
        end

        it "renders the videos show page" do
          post :create, review: { rating: 58 }, video_id: video.id

          response.should render_template "videos/show"
        end

        it "sets the @review variable" do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id

          video.reviews.first.should be_instance_of(Review)
        end
      end
    end
  end
end