require 'spec_helper'

describe ChannelsController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @channel = Channel.create(:name => 'names', :summary => "some summary",:url => "http://www.ixbt.com/export/sec_digimage.rss", :user_id => @user.id)
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index, :id => @user.channels
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @channel.id
      response.should be_success
    end

    it "should contain some feeds" do
      get :show, :id => @channel.id
      @feeds = @channel.feed.all
      @feeds.should_not be_nil
    end

  end

  describe "PUT 'update'" do

    it "should update channel with new name" do
      put :update, :id => @channel.id
      @channel.update_attributes(:name => "new name")
      @n = @channel.name
      @n.should match "new name"
    end

    it "should show right successful message" do
      put :update, :id => @channel.id
      @channel.update_attributes(:name => "new name")
      flash[:notice].should match "Feed successfully updated"
    end

  end

  describe "DELETE 'show'" do
    it "should redirect to channels_url" do
      delete :destroy, :id => @channel.id
      response.should redirect_to(services_path)
    end

    it "should show right successful message" do
      delete :destroy, :id => @channel.id
      flash[:notice].should match "Successfully destroyed channel."
    end
  end

end
