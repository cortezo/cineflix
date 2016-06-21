class VideosController < ApplicationController
  before_action :set_video, only: [:show]

  def show
  end

  def search
    @results = Video.search_by_title(params[:search_term])
    render 'search_results'
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end