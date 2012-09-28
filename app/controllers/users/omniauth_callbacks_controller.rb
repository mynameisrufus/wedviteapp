class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # Facebook callback for omniauth.
  # See: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
  def facebook
    @user = User.find_for_facebook_oauth request.env["omniauth.auth"], current_user

    # If the record is persisted, i.e. it’s not a new record and
    # it was not destroyed, then sign in otherwise redirect to the sign
    # up page. `persisted` is an `ActiveRecord` method.
    #
    # If the user is not persisted then we guess that it's because the
    # allready have a record based on email in the database.
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success",
        kind: "Facebook"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:alert] = I18n.t "devise.omniauth_callbacks.failure",
        kind: "Facebook",
        reason: 'you already have an account.'
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
