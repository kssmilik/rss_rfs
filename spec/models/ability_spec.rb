require 'spec_helper'
require "cancan/matchers"

describe Ability do

  context "when user is Basic" do
    before(:each) do
      @basic = FactoryGirl.create(:basic)
      @ability = Ability.new(@basic)
    end

    it "should allow to read Channel" do
      @ability.should be_able_to(:read,Channel)
    end

    it "should allow to create Channel if it's count less then 10" do
      @ability.should be_able_to(:create, Channel)
    end

    it "should not be able to create Channel if it's count = 10" do
      10.times{ @basic.channels.create(:name => 'name', :summary => "some summary",:url => "http://www.ixbt.com/export/sec_digimage.rss")}
      @ability = Ability.new(@basic)
      @ability.should_not be_able_to(:create, Channel)
    end

    it "should allow to update Channel" do
      @ability.should be_able_to(:update, Channel)
    end

    it "should allow to destroy Channel" do
      @ability.should be_able_to(:destroy, Channel)
    end

    it "should allow to manage comments" do
      @ability.should be_able_to(:manage, Comment)
    end
  end

  context "when user is Medium" do
    before(:each) do
      @medium = FactoryGirl.create(:medium)
      @ability = Ability.new(@medium)
    end

    it "should allow to read Channel" do
      @ability.should be_able_to(:read,Channel)
    end

    it "should allow to create Channel if it's count less then 20" do
      @ability.should be_able_to(:create, Channel)
    end

    it "should not be able to create Channel if it's count = 20" do
      20.times{@medium.channels.create(:name => 'name', :summary => "some summary",:url => "http://www.ixbt.com/export/sec_digimage.rss")}
      @ability = Ability.new(@medium)
      @ability.should_not be_able_to(:create, Channel)
    end

    it "should allow to update Channel" do
      @ability.should be_able_to(:update, Channel)
    end

    it "should allow to destroy Channel" do
      @ability.should be_able_to(:destroy, Channel)
    end

    it "should allow to manage comments" do
      @ability.should be_able_to(:manage, Comment)
    end
  end

  context "when user is Premium" do
    before(:each) do
      @premium = FactoryGirl.create(:premium)
      @ability = Ability.new(@premium)
    end

    it "should allow to read Channel" do
      @ability.should be_able_to(:read,Channel)
    end

    it "should allow to create Channel if it's count less then 20" do
      @ability.should be_able_to(:create, Channel)
    end

    it "should not be able to create Channel if it's count = 100" do
      100.times{@premium.channels.create(:name => 'name', :summary => "some summary",:url => "http://www.ixbt.com/export/sec_digimage.rss")}
      @ability = Ability.new(@premium)
      @ability.should_not be_able_to(:create, Channel)
    end

    it "should allow to update Channel" do
      @ability.should be_able_to(:update, Channel)
    end

    it "should allow to destroy Channel" do
      @ability.should be_able_to(:destroy, Channel)
    end

    it "should allow to manage comments" do
      @ability.should be_able_to(:manage, Comment)
    end

  end


end