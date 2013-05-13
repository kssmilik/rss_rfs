class FeedsController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource :channel
  load_and_authorize_resource :feed #, :through => :channel


  def show
    @channels = current_user.channels
    @feed = Feed.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @feeds }
    end
  end

  def check_as_favourite
    @feed = Feed.find(params[:feed_id])
    if @feed.favourite
      @feed.favourite = false
    else
      @feed.favourite = true
    end
    @feed.save
    redirect_to feed_path(@feed)
  end

end
