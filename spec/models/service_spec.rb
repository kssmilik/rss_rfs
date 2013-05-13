require 'spec_helper'

describe Service do

  it "should be instance of Service" do
    @service = Service.new( :provider => "google",
                            :uid => "https://www.google.com/accounts/",
                            :uname => "Kate Kasinskaya",
                            :uemail => "kasinskayakate@gmail.com")
    @service.should be_an_instance_of Service
  end

end
