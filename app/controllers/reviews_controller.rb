class ReviewsController < ApplicationController
  before_action :require_user
  before_action :set_video

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @video      #"videos/#{@review.video.id}"
    else
      flash[:error] = "Review creation failed."
      @video_reviews = @video.reviews.reload
      render 'videos/show', video: @video, video_reviews: @video_reviews #this ditches the invalid .new that is present from above.
    end
  end

  def edit

  end

  def update
    if @review.update(review_params)
      flash[:notice] = "Review successfully updated."
      redirect_to @video
    else
      render "video/show"
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