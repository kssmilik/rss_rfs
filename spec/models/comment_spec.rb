require 'spec_helper'

describe Comment do

  before :each do
    @user = FactoryGirl.create(:user)
    @channel = Channel.create(:name => 'names', :summary => "some summary",:url => "http://www.ixbt.com/export/sec_digimage.rss", :user_id => @user.id)
    @feeds = @channel.feed.all
    @feed = @feeds.first
    @comment = Comment.new(:body => "some text goes here :) ")
  end

  describe "#new" do
    it "takes parameters and returns a Comment object" do
      @comment.should be_an_instance_of Comment
    end

  end

  context "valid comments" do
    it "should reject comment without text" do
        @not_valid_comment  = Comment.new( :body => nil)
        @not_valid_comment.should_not be_valid
      end
  end

  #describe "" do
  #
  #end

end