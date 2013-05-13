require 'spec_helper'

describe Channel do

  before :each do
    @channel = Channel.new(:name => "Channel name", :summary => "some summary",
                         :url => "http://www.ixbt.com/export/sec_digimage.rss",)
  end

  describe "#new" do
    it "takes parameters and returns a Channel object" do
      @channel.should be_an_instance_of Channel
    end
  end

  context "valid urls" do
    it "should accept valid url" do
      urls = %w[http://www.ixbt.com/export/sec_digimage.rss http://studio102.ru/log/rss/]
      urls.each do |url|
        @channel.url  = url
        @channel.should be_valid
      end
    end

    it "should reject invalid url" do
      urls = %w[www.ixbt.com/export/sec_digimage.rss http://studio102.ru/log/ http://studio102.ru/log.hml csdcscdcsvddsvdsv]
      urls.each do |url|
        @channel.url  = url
        @channel.should_not be_valid
      end
    end
  end
end
