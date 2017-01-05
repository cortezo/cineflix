class QueueItemsController < ApplicationController
  before_action :require_user
  before_action :set_queue_item, only: [:destroy]

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])

    @queue_item = QueueItem.new(video: video, user: current_user, position: new_queue_item_position)

    if @queue_item.save
      flash[:info] = "#{video.title} was added to your queue."
      redirect_to video_path(video)
    else
      flash[:error] = "There was a problem adding the video to your queue."
      redirect_to video_path(video)
    end
  end

  def destroy
    if current_user.queue_items.include?(@queue_item)
      @queue_item.destroy
      flash[:info] = "Item removed from queue."
      redirect_to my_queue_path
    else
      flash[:error] = "You cannot delete that queue item."
      redirect_to my_queue_path
    end

    # NEED TO CREATE A WAY FOR POSITION OF QUEUE ITEMS TO GET UPDATED WHEN ONE IS REMOVED OR CHANGED.
  end

  private

  def queue_item_params
    params.require(:queue_item).permit(:video_id, :user_id, :position)
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def set_queue_item
    @queue_item = QueueItem.find(params[:id])
  end
end