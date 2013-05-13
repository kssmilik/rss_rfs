module ServicesHelper

def get_omniauth_params(omni, service_route)
    if  service_route == 'google'
      omni.info.email ? email =  omni.info.email : email = ''
      omni.info.name ? name =  omni.info.name : name = ''
      omni.info.first_name ? first_name =  omni.info.first_name : first_name = ''
      omni.info.last_name ? last_name =  omni.info.last_name : last_name = ''
      omni.uid ? uid =  omni.uid : uid = ''
      omni.provider ? provider =  omni.provider : provider = ''
      
      return email, name, first_name, last_name, uid, provider

    elsif service_route == 'twitter'
      email = ''    # Twitter API never returns the email address
      omni.info.name ? name =  omni.info.name : name = ''
      omni.info.first_name ? first_name =  omni.info.first_name : first_name = ''
      omni.info.last_name ? last_name =  omni.info.last_name : last_name = ''
      omni.uid ? uid =  omni.uid : uid = ''
      omni.provider ? provider =  omni.provider : provider = ''

      return email, name, first_name, last_name, uid, provider
    else
      render :text => omniauth.to_yaml
      return
    end
end

def login_via_service(existing_user)
    # login via a service provider to an existing account if the email address is the same
    existing_user.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
    flash[:notice] = 'Sign in via ' + provider.capitalize + ' has been added to your account ' + existing_user.email + '. Signed in successfully!'
    sign_in_and_redirect(:user, existing_user)
  end

  def create_user_via_service(email, name, first_name, last_name, uid, provider)
    #create a new user: register this user and add this authentication method for this user
    password = "password"
    user = User.new :email => email, :password => password , :password_confirmation => password,
                    :first_name => first_name, :last_name => last_name,  :profile => "basic"
    # add this authentication service to our new user
    user.services.build(:provider => provider, :uid => uid, :uname => name, :uemail => email)
    user.skip_confirmation!
    user.save!
    user.confirm!
    flash[:myinfo] = 'You have been registered via ' + provider.capitalize + '. Please add a local password. current password: password)'
    sign_in_and_redirect(:user, user)
  end

def search_user_by_email(email, name, first_name, last_name, uid, provider)
    # search for a user with this email address
    existing_user = User.find_by_email(email)
    if existing_user
      login_via_service(existing_user)
    else
      create_user_via_service(email, name, first_name, last_name, uid, provider)
    end
  end

  def do_if_already_registered_with_email(email, name, first_name, last_name, uid, provider)
    # check if this user is already registered with this email address; get out if no email has been provided
    if email != ''
      search_user_by_email(email, name, first_name, last_name, uid, provider)
    else
      flash[:error] =  service_route.capitalize + ' can not be used to sign-up as no valid email address has been provided.'
      redirect_to new_user_session_path
    end
  end

  def do_if_user_not_signed_in(email, name, first_name, last_name, uid, provider)
    # check if user has already signed in using this service provider and continue with sign in process if yes
    auth = Service.find_by_provider_and_uid(provider, uid)
    if auth
      flash[:notice] = 'Signed in successfully via ' + provider.capitalize + '.'
      sign_in_and_redirect(:user, auth.user)
    else
      do_if_already_registered_with_email(email, name, first_name, last_name, uid, provider)
    end
  end

  def do_if_user_already_signed_in(email, name, uid, provider)
    # the user is currently signed in, check if this service is already linked to his/her account, if not, add it
    auth = Service.find_by_provider_and_uid(provider, uid)
    if !auth
      current_user.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
      flash[:notice] = 'Sign in via ' + provider.capitalize + ' has been added to your account.'
      redirect_to services_path
    else
      flash[:notice] = service_route.capitalize + ' is already linked to your account.'
      redirect_to services_path
    end
  end

  def failure
    flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
    redirect_to root_url
  end 

end
