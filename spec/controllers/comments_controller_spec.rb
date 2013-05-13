require 'spec_helper'

describe CommentsController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @channel = Channel.create(:name => 'names', :summary => "some summary",:url => "http://www.ixbt.com/export/sec_digimage.rss", :user_id => @user.id)
    sign_in @user
  end

end
