module AuthenticationHelper

  private

  # Returns the default URL to which the system should redirect the user after successful authentication
  def default_redirect_url_after_sign_in
    user_dashboard_url
  end

  # Returns the default URL to which the system should redirect the user after an unsuccessful attempt to authorise a resource/page
  def default_sign_in_url
    user_sign_in_url
  end

  # Method to handle the redirection after unsuccesful authentication
  # This method should also handle the redirection if it has come through a client appliction for authentication
  # In that case, it should persist the params passed by the client application
  def redirect_after_unsuccessful_authentication
    params_hsh = {}
    params_hsh[:client_app] = params[:client_app] if params[:client_app]
    params_hsh[:redirect_back_url] = params[:redirect_back_url] if params[:redirect_back_url]
    sign_in_url = add_query_params(default_sign_in_url, params_hsh)
    redirect_to sign_in_url
  end

  # Method to redirect after successful authentication
  # This method should also handle the requests forwarded by the client for authentication
  def redirect_to_appropriate_page_after_sign_in
    if params[:redirect_back_url]
      redirect_to params[:redirect_back_url]
    else
      redirect_to default_redirect_url_after_sign_in
    end
    return
  end

  # This method is widely used to create the @current_user object from the session
  # This method will return @current_user if it already exists which will save queries when called multiple times
  def current_user
    return @current_user if @current_user
    # Check if the user exists with the auth token present in session
    @current_user = User.find_by_id(session[:id])
    @current_admin = @current_user if @current_user and (@current_user.is_super_admin? || @current_user.is_admin?)
    @current_user
  end

  # This method is usually used as a before filter to secure some of the actions which requires the user to be signed in.
  def require_user
    current_user
    unless @current_user
      @heading = translate("authentication.error")
      @alert = translate("authentication.permission_denied")
      store_flash_message("#{@heading}: #{@alert}", :errors)
      redirect_to default_sign_in_url
    end
  end

  # This method is usually used as a before filter from admin controllers to ensure that the logged in user is an admin
  def require_admin
    current_user
    unless @current_admin
      @heading = translate("authentication.error")
      @alert = translate("authentication.permission_denied")
      store_flash_message("#{@heading}: #{@alert}", :errors)
      redirect_to default_sign_in_url
    end
  end

  # This method is only used for masquerading. When admin masquerade as user A and then as B, when he logs out as B he should be logged in back as A
  # This is accomplished by storing the last user id in session and activating it when user is logged off
  def restore_last_user
    return @last_user if @last_user
    if session[:last_user_id].present?
      @last_user = User.find_by_id(session[:last_user_id])
      session.destroy()
      session[:id] = @last_user.id if @last_user.present?
      return @last_user
    end
  end

end
