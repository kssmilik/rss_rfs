class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private
  def record_not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

end
