module Public
  class UserSessionsController < ApplicationController

    before_filter :require_user, :only => :sign_out
    before_filter :set_navs

    layout 'sign_in'

    def sign_in
      redirect_to_appropriate_page_after_sign_in if @current_user && !@current_user.token_expired?
    end

    ## This method will accept a proc, execute it and render the json
    def create_session

      # Fetching the user data (email / username is case insensitive.)
      @user = User.where("LOWER(email) = LOWER('#{params['email']}')").first

      # If the user exists with the given username / password
      if @user
        # Check if the user is not approved (pending, locked or blocked)
        # Will allow to login only if status is approved
        if @user.status != ConfigCenter::User::ACTIVE
          #puts "#{@user.email} id not activated".yellow
          set_notification_messages(I18n.t("authentication.user_is_#{@user.status.downcase}_heading"), I18n.t("authentication.user_is_#{@user.status.downcase}_message"), :error)
          redirect_or_popup_to_default_sign_in_page
          return
        # Check if the password matches
        # Invalid Login: Password / Username doesn't match
        elsif @user.authenticate(params['password']) == false
          #puts "#{@user.email} not authenticated".yellow
          set_notification_messages(I18n.t("authentication.invalid_login_heading"), I18n.t("authentication.invalid_login_message"), :error)
          redirect_or_popup_to_default_sign_in_page
          return
        end
        #puts "#{@user.email} logged in".yellow

        # If successfully authenticated.
        set_notification_messages(I18n.t("authentication.logged_in_successfully_heading"), I18n.t("authentication.logged_in_successfully_message"), :success)
        session[:id] = @user.id
        @user.start_session

        # Set the current_user
        @current_user = @user

        redirect_to_appropriate_page_after_sign_in
        return
      # If the user with provided email doesn't exist
      else
        #puts "#{params['email']} not found".yellow
        set_notification_messages(I18n.t("authentication.invalid_login_heading"), I18n.t("authentication.invalid_login_message"), :error)
        redirect_after_unsuccessful_authentication
        return
      end
    end

    def sign_out
      set_notification_messages(I18n.t("authentication.logged_out_successfully_heading"), I18n.t("authentication.logged_out_successfully_message"), :success)
      # Reseting the auth token for user when he logs out.
      @current_user.update_attributes auth_token: SecureRandom.hex, token_created_at: nil
      session.delete(:id)
      restore_last_user
      redirect_after_unsuccessful_authentication
    end

    private

    def set_navs
      set_nav("Login")
    end

  end
end
