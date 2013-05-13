class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @channels = current_user.channels
  end

  def new
    @channels = Channel.paginate(:page => params[:page], :per_page => 10)
    @channel  = Channel.new
  end

  def create
    expire_fragment(controller: 'channels',action: 'show', id: @channel.id)
    @user = current_user
    @channel = Channel.new(params[:channel])
    @channel.user << @user
    if @channel.save
      @channel.set_name_form_link
      Resque.enqueue(FeedJob, @channel.id)
      flash[:notice] = "Successfully created channel."
      redirect_to @channel
    else
      render :new
    end
  end

  def show
    @channels = current_user.channels
    @channel = Channel.find(params[:id])
    @feeds = @channel.feed.all(:limit => '10' , :order => "published_at desc").paginate(page: params[:page], per_page: 5)
    if @feeds.nil?
      @feeds = []
    end
  end

  def edit
    @channel = Channel.find(params[:id])
  end

  def update
    @channel = Channel.find(params[:id])
    @feeds = @channel.feed
    # expire_fragment(:controller=>"channels",:action=>"show", :id => @channel.id)
    if @channel.update_attributes(params[:channel])
      flash[:notice] = "Feed successfully updated"
      redirect_to root_path
    else
      render :action => "edit"
    end
  end

  def destroy
    # expire_fragment(:controller=>"channels",:action=>"show", :id => @channel.id)
    @user = current_user
    @channel = Channel.find(params[:id])
    @channel.destroy
    flash[:notice] = "Successfully destroyed channel."
    redirect_to channels_url
  end

  def add_channel_to_user
      # expire_fragment(:controller=>"channels",:action=>"show", :id => @channel.id)
      @user = current_user
      @channel = Channel.find(params[:channel_id])
      if !@channel.user.include?(@user)
        @channel.user << @user
        @channel.save
      else
        @channel.user.delete(@user)
        @channel.save
      end
      redirect_to new_channel_path
  end

end
