module SessionsHelper
  def sign_in(user)

    #cookies[:remember_token] = { value:   user.remember_token,
    #                             expires: 20.years.from_now.utc }
    cookies.permanent[:remember_token] = user.remember_token #shorthand for the upper statement

    # Invoke a method
    self.current_user = user

    # Sets a instance variable
    #@current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:notice] = "Please sign in."
      redirect_to signin_url
    end
    # equivalent shortcut
    #redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end
end
