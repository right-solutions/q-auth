module Public
  class UserSessionsController < ApplicationController

    layout 'poodle/public'

    before_filter :require_user, :only => :sign_out

    def sign_in
      redirect_to_appropriate_page_after_sign_in if @current_user && !@current_user.token_expired?
    end

    def create_session
      @registration_details = AuthenticationService.new(params)
      if @registration_details.error
        set_notification_messages(@registration_details.error, :error)
        redirect_or_popup_to_default_sign_in_page
        return
      else
        @user = @registration_details.user
        session[:id] = @user.id
        @current_user = @user
        set_notification_messages("authentication.logged_in", :success)
        redirect_to_appropriate_page_after_sign_in
        return
      end
    end

    def sign_out
      set_notification_messages("authentication.logged_out", :success)
      @current_user.end_session
      session.delete(:id)
      restore_last_user
      redirect_after_unsuccessful_authentication
    end

  end
end
