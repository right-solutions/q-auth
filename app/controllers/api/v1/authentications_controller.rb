module Api
  module V1
    class AuthenticationsController < Api::V1::BaseController

      skip_before_filter :require_auth_token, :only => :create

      def create

        proc_code = Proc.new do

          # Fetching the user data (email / username is case insensitive.)
          @user = User.find_by_email_or_username(params['login_handle'])

          # If the user exists with the given username / password
          if @user
            # Check if the user is not approved (pending, locked or blocked)
            # Will allow to login only if status is approved
            if @user.status != ConfigCenter::User::ACTIVE
              set_notification_messages(I18n.t("authentication.user_is_#{@user.status.downcase}_heading"), I18n.t("authentication.user_is_#{@user.status.downcase}_message"), :error)
              raise InvalidLoginError
            # Check if the password matches
            # Invalid Login: Password / Email doesn't match
            elsif @user.authenticate(params['password']) == false
              set_notification_messages(I18n.t("authentication.invalid_login_heading"), I18n.t("authentication.invalid_login_message"), :error)
              raise InvalidLoginError
            end
          # If the user with provided email doesn't exist
          else
            set_notification_messages(I18n.t("authentication.invalid_login_heading"), I18n.t("authentication.invalid_login_message"), :error)
            raise InvalidLoginError
          end

          # If successfully authenticated.
          set_notification_messages(I18n.t("authentication.logged_in_successfully_heading"), I18n.t("authentication.logged_in_successfully_message"), :success)
          @data = @user
          @success = true

        end
        render_json_response(proc_code)
      end

      def destroy
        proc_code = Proc.new do

          # Reseting the auth token for user when he logs out.
          @current_user.update_attribute :auth_token, SecureRandom.hex

          # If successfully authenticated.
          set_notification_messages(I18n.t("authentication.logged_out_successfully_heading"), I18n.t("authentication.logged_out_successfully_message"), :success)

        end

        render_json_response(proc_code)

      end

    end
  end
end
