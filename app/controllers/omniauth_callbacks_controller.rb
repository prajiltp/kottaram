class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	skip_before_action :authenticate_and_configure
  def google_oauth2
	  # You need to implement the method below in your model (e.g. app/models/user.rb)
	  @user = User.from_omniauth(request.env["omniauth.auth"])

	  if @user && @user.persisted?
	    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
	    binding.pry
	    sign_in @user, bypass: true
	    redirect_to events_path
	  else
	    session["devise.google_data"] = request.env["omniauth.auth"].except(:extra) #Removing extra as it can overflow some session stores
	    redirect_to root_path, alert: "Ningal njanglude vittile allalala"
	  end
  end

  def failure
    redirect_to root_path
  end
end