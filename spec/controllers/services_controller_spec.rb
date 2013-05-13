require 'spec_helper'

describe ServicesController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    @user.services.create(:provider => "google")
    @user_service = @user.services.first
    sign_in @user
  end

  describe "GET 'index' "  do
    it "should be successful " do
      get :index
      response.should be_success
    end
  end

  describe "DELETE 'show'" do
    it "should redirect to services_path" do
      delete :destroy, :id => @user_service.id
      response.should redirect_to(services_path)
    end
  end

end
