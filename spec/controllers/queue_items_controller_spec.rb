require 'spec_helper'

describe QueueItemsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }

    context "with UNauthenticated user" do
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
        post :create, video_id: video.id
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

      it "creates the queueitem as the last item in the queue" do
        video2 = Fabricate(:video)
        post :create, video_id: video2.id
        current_user.queue_items.last.video.should eq(video2)
      end

      it "doesn't add the video to the queue if it is already in queue" do
        post :create, video_id: video.id
        current_user.queue_items.count.should eq(1)
      end
    end
  end

  describe "GET index" do
    context "with UNauthenticated user" do
      before do
        get :index
      end

      it "redirects to sign in page" do
        response.should redirect_to sign_in_path
      end
    end

    context "with authenticated user" do
      let(:user) { Fabricate(:user) }
      let(:video1) { Fabricate(:video) }
      let(:video2) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: user, video: video1, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: user, video: video2, position: 2) }
      before do
        session[:user_id] = user.id
        get :index
      end

      it "sets @queue_items to the queue for the current_user" do
        expect(assigns(:queue_items)).to match_array [queue_item1, queue_item2]
      end

      it "should render the my queue page" do
        response.should render_template "index"
      end
    end
  end

  describe "DELETE destroy" do
    let(:user1) { Fabricate(:user) }
    let(:user2) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    context "with UNauthenticated user" do
      it "doesn't destroy the object" do
        queue_item = Fabricate(:queue_item)

        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end

      it "redirects to sign in page" do
        queue_item = Fabricate(:queue_item)

        delete :destroy, id: queue_item.id
        response.should redirect_to sign_in_path
      end
    end

    context "with authenticated user" do
      before do
        session[:user_id] = user1.id
      end
      
      it "deletes the queue item" do
        queue_item = Fabricate(:queue_item, user: user1)

        delete :destroy, id: queue_item.id
        QueueItem.count.should eq(0)
      end

      it "redirects to the my_queue page" do 
        queue_item = Fabricate(:queue_item)

        delete :destroy, id: queue_item.id
        response.should redirect_to my_queue_path
      end

      it "does not delete the queue item if current user does not own the queue item" do
        queue_item1 = Fabricate(:queue_item, user: user1)
        queue_item2 = Fabricate(:queue_item, user: user2)

        delete :destroy, id: queue_item2.id
        expect(QueueItem.count).to eq(2)
      end
    end
  end
end