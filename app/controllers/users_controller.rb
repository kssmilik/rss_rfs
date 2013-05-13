class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  	@channels = @user.channels
  end

  def edit
    @user = Channel.find(params[:id])
  	@channels = @user.channels
  end

  def update
    @user = Channel.find(params[:id])
    if @user.update_attributes(params[:users])
      flash[:notice] = "Feed successfully updated"
      redirect_to root_path
    else
      render :action => "edit"
    end
  end


end
