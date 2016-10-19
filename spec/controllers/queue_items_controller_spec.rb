require 'spec_helper'

describe QueueItemsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }

    context "without authenticated user" do
      before do
        post :create, video_id: video.id
      end

      it "doesn't create the queueitem object" do
        expect(QueueItem.all).to eq([])
      end
      it "redirects to sign in page" do
        response.should redirect_to sign_in_path
      end
      it "doesn't set the @video variable" do
        expect(@video).to be_nil
      end
    end

    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        post :create, video_id: video.id, user_id: current_user.id
      end

      it "redirects to the video show page" do
        response.should redirect_to video_path(video)
      end
      it "creates the queueitem associated with current user" do
        QueueItem.first.user_id.should eq(current_user.id)
      end
      it "creates the queueitem associated with the video" do
        QueueItem.first.video_id.should eq(video.id)
      end
    end
  end

  describe "GET index" do
    context "without authenticated user" do
      before do
        get :index
      end

      it "redirects to sign in page" do
        response.should redirect_to sign_in_path
      end
    end

    context "with authenticated user" do
      let(:current_user) { Fabricate(:user) }
      let(:video1) { Fabricate(:video) }
      let(:video2) { Fabricate(:video) }
      let(:queue_item1) { QueueItem.create(user_id: current_user.id, video_id: video1.id) }
      let(:queue_item2) { QueueItem.create(user_id: current_user.id, video_id: video2.id) }
      before do
        session[:user_id] = current_user.id
        get :index
      end

      it "should return an array of queueitems for the current_user" do
        expect(assigns(:queue_items)).to match_array [queue_item1, queue_item2]
      end
      it "should render the my queue page" do
        response.should render_template "index"
      end
    end
  end
end