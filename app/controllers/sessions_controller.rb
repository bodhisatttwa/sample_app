class SessionsController < ApplicationController
  # HTTP: GET
  # URI: /signin
  # Action: new
  def new
  end

  # HTTP: POST
  # URI: /sessions
  # Action: create
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      #redirect_to user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
    #render 'new'
  end

  # HTTP: DELETE
  # URI: /signout
  # Action: destroy
  def destroy
    sign_out
    redirect_to root_url
    #render 'static_pages/home'
  end
end
