class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.save
    if !current_user
      current_user = @user
    end
    sign_in_and_redirect @user 
  end
end