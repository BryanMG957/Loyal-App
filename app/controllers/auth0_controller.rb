class Auth0Controller < ApplicationController

  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:userinfo] = request.env['omniauth.auth']
    # Retrieve User Info
    raw_info = session[:userinfo][:extra][:raw_info]
    user_id = raw_info[:identities][0][:user_id]
    provider = raw_info[:identities][0][:provider]
    fullname = raw_info[:name]
    email = raw_info[:email]
    if (fullname)
      name = fullname.split(" ")
    end
    result = Employee.find_by(user_id: user_id, provider: provider)
    if (result)
      session[:userinfo][:employee] = result.id
    else
      # create new employee      
      (name[0] ? first_name = name[0] : first_name = "User")
      (name[1] ? last_name = name[0] : last_name = "User")
      e = Employee.create(first_name: first_name, last_name: last_name, user_id: user_id, provider: provider, is_admin?: true)
      session[:userinfo][:employee] = e.id
    end
    # Redirect to the URL you want after successful auth
    redirect_to calendarmain_path
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end

  def destroy
    session.delete(:userinfo)
    redirect_to root_url
  end
end
