class SessionsController < ApplicationController
	
	def create

    	raise request.env["omniauth.auth"].to_yaml

		auth = request.env["omniauth.auth"]
		user = User.where(:provider => auth['provider'], 
                    :uid => auth['uid']).first || User.create_with_omniauth(auth)
		session[:user_id] = user.id
		redirect_to root_url, :notice => "Signed in!"

  	end


	def destroy
		reset_session
		redirect_to root_url, :notice => 'Signed out!'
	end


	def failure
		redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
	end


	def new
		redirect_to '/auth/twitter'
	end

end
