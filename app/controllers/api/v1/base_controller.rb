module Api
  module V1
    class BaseController < ActionController::API

      include ActionController::HttpAuthentication::Token::ControllerMethods
      include ApiHelper
      include ParamsParserHelper
      include NotificationHelper

      before_filter :require_auth_token

    end
  end

end
