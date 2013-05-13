require 'spec_helper'

describe Feed do

  it "should be instance of Feed" do
    @feed = Feed.new( )
    @feed.should be_an_instance_of Feed
  end

end
