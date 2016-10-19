class VideosController < ApplicationController
  before_action :require_user
  before_action :set_video, only: [:show]

  def show
    @video_reviews = @video.reviews.sort {|a,b| b.created_at <=> a.created_at}
    @review = Review.new
    @queue_item = QueueItem.new
  end

  def search
    @results = Video.search_by_title(params[:search_term])
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end