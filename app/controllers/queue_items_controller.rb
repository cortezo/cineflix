class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])

    @queue_item = QueueItem.new(video_id: video.id, user_id: current_user.id)

    if @queue_item.save
      redirect_to video_path(video)
    else
      flash[:error] = "There was a problem adding the video to your queue."
      render "video/show"
    end
  end

  private

  def queue_item_params
    params.require(:queue_item).permit(:video_id, :user_id)
  end
end