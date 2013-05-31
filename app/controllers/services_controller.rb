class ServicesController < ApplicationController
  include ServicesHelper

  before_filter :authenticate_user!, :except => [:create]
  # protect_from_forgery :except => :create
  def index
    @services = current_user.services.order('provider asc')
  end

  def create
    params[:service] ? service_route = params[:service] : service_route = 'no service (invalid callback)'
    omniauth = request.env['omniauth.auth']

     if omniauth and params[:service]
        email, name, first_name, last_name, uid, provider = get_omniauth_params(omniauth, service_route)
        if uid != '' and provider != ''
          if !user_signed_in?
            do_if_user_not_signed_in(email, name, first_name, last_name, uid, provider)
          else
            do_if_user_already_signed_in(email, name, uid, provider)
          end
        else
          flash[:error] =  service_route.capitalize + ' returned invalid data for the user id.'
          redirect_to new_user_session_path
        end
    else
      flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '.'
      redirect_to new_user_session_path
    end
  end

def signout
    if current_user
      session[:user_id] = nil
      session[:service_id] = nil
      session.delete :user_id
      session.delete :service_id
      flash[:notice] = 'You have been signed out!'
    end
    redirect_to root_url
end

  def destroy
    @service = current_user.services.find(params[:id])
    if session[:service_id] == @service.id
      flash[:error] = 'You are currently signed in with this account!'
    else
      @service.destroy
    end
    redirect_to services_path
  end

end
