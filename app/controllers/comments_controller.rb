class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @feed = Feed.find(params[:feed_id])
    @comment = @feed.comments.create(params[:comment])
    redirect_to feed_path(@feed)
  end

  def destroy
    @feed = Feed.find(params[:feed_id])
    @comment = @feed.comments.find(params[:id])
    @comment.destroy
    redirect_to feed_path(@feed)
  end

end
