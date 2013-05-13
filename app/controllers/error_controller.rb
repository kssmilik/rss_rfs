class ErrorController < ApplicationController
  def handle404
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
