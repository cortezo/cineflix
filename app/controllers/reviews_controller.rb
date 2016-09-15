class ReviewsController < ApplicationController
  before_action :require_user
  before_action :set_video

  def create
    @review = @video.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to :back      #"videos/#{@review.video.id}"
    else
      flash[:error] = "Review creation failed."
      redirect_to :back
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end