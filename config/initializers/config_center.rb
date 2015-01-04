module ConfigCenter

  module GeneralValidations

    # xxxx@yyyy.zzz format
    EMAIL_FORMAT_REG_EXP = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i

    # xxx-xxx-xxxx format
    MOBILE_FORMAT_REG_EXP = /\A([0-9\(\)\/\+ \-]){3}-([0-9\(\)\/\+ \-]){3}-([0-9\(\)\/\+ \-]){4}\z/i

    # xxx-xxx-xxxx format
    PHONE_FORMAT_REG_EXP = /\A\(([0-9\(\)\/\+ \-]){3}\) ([0-9\(\)\/\+ \-]){3}-([0-9\(\)\/\+ \-]){4}\z/i

    # Generic Name
    # a to z (both upper and lower case), 1 to 9, space, dot(.) and curly brackets "(" & ")" allowed.
    NAME_MIN_LEN = 2
    NAME_MAX_LEN = 256
    NAME_FORMAT_REG_EXP = /\A[a-zA-Z1-9\-\ \(\)\.+]*\z/i

    # User Name
    # Minimum length is 6 by default and maximum length is 32 by default
    # Only characters (both upper and lowercase), numbers, dot(.), underscore (_)
    # No spaces, hyphen or any other special characters are allowed
    USERNAME_MIN_LEN = 6
    USERNAME_MAX_LEN = 128
    USERNAME_FORMAT_REG_EXP = /\A[a-zA-Z0-9\_]*\z/

    # Password
    # should have atleast 1 Character (a to z (both upper and lower case))
    # and 1 Number (1 to 9)
    # and 1 Special Character from (!,@,$,&,*,_)",
    PASSWORD_MIN_LEN = 7
    PASSWORD_MAX_LEN = 256
    PASSWORD_FORMAT_REG_EXP = /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9!@$#&*_\.,;:])/
    # PASSWORD_FORMAT_REG_EXP = /\A(?=.*?[a-z][A-Z])(?=.*?\d)(?=.*?[!@$&*_])/i

  end

  module Defaults

    # the default number of milli seconds for which resource listing pages gets refreshed:
    REFRESH_PAGE_IN_MILLI_SECONDS = 180000

    # It will list 10 items per page unless user request to load more (this is done by passing 'per_page' in url)
    ITEMS_PER_LIST = 10
    # It will override the per_page to 10 (default val - ITEMS_PER_LIST), in case if the user request for more items to load in a single listing page.
    # i.e if user passes per_page=251 (greater than MAX_ITEMS_PER_LIST), system will ignore it and fall back to default no of items to be listed in a page (ITEMS_PER_LIST)
    MAX_ITEMS_PER_LIST = 250

    # Default password to be assigned while mocking a user
    PASSWORD = "Password@1"

    # Other constans should follow here.
    EXCLUDED_JSON_ATTRIBUTES = [:created_at, :updated_at]

    SESSION_TIME_OUT = 30.minutes

    ##
    def host
      case Rails.env
      when "development"
        'http://localhost:3000'
      when "it"
        'http://it.q-auth.qwinixtech.com'
      when "uat"
        'http://uat.q-auth.qwinixtech.com'
      when "production"
        'http://q-auth.qwinixtech.com'
      else
        'http://localhost:3000'
      end
    end
  end

  module User

    INACTIVE = "inactive"
    ACTIVE = "active"
    SUSPEND = "suspended"
    STATUS_LIST = ["inactive", "active", "suspended"]

    EXCLUDED_JSON_ATTRIBUTES = [:designation_id, :department_id, :confirmation_token, :password_digest, :reset_password_token, :unlock_token, :status, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :locked_at, :created_at, :updated_at]

  end

  module QApps
    QAUTH_URL = "http://localhost:9001"
    QPROJECTS_URL = "http://localhost:9002"
    QTIME_URL = "http://localhost:9003"
    QLEAVES_URL = "http://localhost:9004"
    QMEETING_URL = "http://localhost:9005"
    QASSETS_URL = "http://localhost:9006"

    QMESSAGES_URL = "http://localhost:9008"
    QSECURE_URL = "http://localhost:9007"
    QSERVERS_URL = "http://localhost:9009"
    QRECRUIT_URL = "http://localhost:9010"
    QCAREER_URL = "http://localhost:9011"
  end


end
