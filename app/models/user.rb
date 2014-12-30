class User < ActiveRecord::Base

  has_secure_password

  # Callbacks
  before_create :generate_auth_token

  # Validations
  validates :name,
    :presence => true,
    :length => {:minimum => ConfigCenter::GeneralValidations::NAME_MIN_LEN ,
      :maximum => ConfigCenter::GeneralValidations::NAME_MAX_LEN},
      :format => {:with => ConfigCenter::GeneralValidations::NAME_FORMAT_REG_EXP}

  validates :username,
    :presence => true,
    :uniqueness => {:case_sensitive => false},
    :length => {:minimum => ConfigCenter::GeneralValidations::USERNAME_MIN_LEN ,
      :maximum => ConfigCenter::GeneralValidations::USERNAME_MAX_LEN},
      :format => {:with => ConfigCenter::GeneralValidations::USERNAME_FORMAT_REG_EXP}

  validates :status, :presence=> true, :inclusion => { :in => ConfigCenter::User::STATUS_LIST }

  validates :email,
    :presence => true,
    :uniqueness => {:case_sensitive => false},
    :format => {:with => ConfigCenter::GeneralValidations::EMAIL_FORMAT_REG_EXP}

  validates :password,
    :presence => true,
    :length => {:minimum => ConfigCenter::GeneralValidations::PASSWORD_MIN_LEN ,
    :maximum => ConfigCenter::GeneralValidations::PASSWORD_MAX_LEN},
    :format => {:with => ConfigCenter::GeneralValidations::PASSWORD_FORMAT_REG_EXP},
    :if => proc {|user| user.new_record? || (user.new_record? == false and user.password.present?)}

  validates :status, :inclusion => {:in => ConfigCenter::User::STATUS_LIST, :presence_of => :status, :message => "%{value} valid name..." }
  # Callbacks
  before_create :generate_auth_token, :assign_default_password_if_nil


  # Associations
  belongs_to :designation
  belongs_to :department
  has_one :profile_picture, :as => :imageable, :dependent => :destroy, :class_name => "Image::ProfilePicture"

  state_machine :status, :initial => :inactive do

    event :active do
      transition :inactive => :active
    end

    event :suspend do
      transition :active => :suspend
    end

    event :active do
      transition :suspend => :active
    end

  end

  # FIX ME - Specs need to be written
  def self.find_by_email_or_username(query)
    self.where("LOWER(email) = LOWER('#{query}') OR LOWER(username) = LOWER('#{query}')").first
  end

  def generate_auth_token
    self.auth_token = SecureRandom.hex unless self.auth_token
  end

  # Exclude some attributes info from json output.
  def as_json(options={})
    inclusion_list = []
    inclusion_list << {:department => {:except => ConfigCenter::Defaults::EXCLUDED_JSON_ATTRIBUTES}} if department.present?
    inclusion_list << {:designation => {:except => ConfigCenter::Defaults::EXCLUDED_JSON_ATTRIBUTES}} if designation.present?
    options[:include] ||= inclusion_list

    exclusion_list = []
    exclusion_list += ConfigCenter::Defaults::EXCLUDED_JSON_ATTRIBUTES
    exclusion_list += ConfigCenter::User::EXCLUDED_JSON_ATTRIBUTES
    options[:except] ||= exclusion_list

    options[:methods] = []
    options[:methods] << :profile_image

    super(options)
  end

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> user.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(name) LIKE LOWER('%#{query}%') OR\
                                        LOWER(username) LIKE LOWER('%#{query}%') OR\
                                        LOWER(email) LIKE LOWER('%#{query}%') OR\
                                        LOWER(city) LIKE LOWER('%#{query}%') OR\
                                        LOWER(state) LIKE LOWER('%#{query}%') OR\
                                        LOWER(phone) LIKE LOWER('%#{query}%')")
                        }

  # * Return full name
  # == Examples
  #   >>> user.display_name
  #   => "Joe Black"
  def display_name
    "#{name}"
  end

  def department_name
    department.blank? ? nil : department.name
  end

  def designation_title
    designation.blank? ? nil : designation.title
  end

  def profile_image
    if (profile_picture && profile_picture.image)
      {
        thumb: profile_picture.image.thumb.url,
        medium: profile_picture.image.medium.url,
        large: profile_picture.image.large.url,
        original: profile_picture.image.url
      }
    else
      {}
    end
  end

  # * Return the designation text
  # If the user has overridden the designation it will return that, else it will populate the display from the associated designation and department
  # == Examples
  #   >>> user.display_designation
  #   => "Joe Black"
  def display_designation
    return "#{designation_overridden}" if designation_overridden
    designation_list = []
    designation_list << designation.title unless designation.blank?
    designation_list << department.name unless department.blank?
    designation_list.join(", ")
  end

  # * Return address which includes city, state & country
  # == Examples
  #   >>> user.display_address
  #   => "Mysore, Karnataka, India"
  def display_address
    address_list = []
    address_list << city unless city.blank?
    address_list << state unless state.blank?
    address_list << country unless country.blank?
    address_list.join(", ")
  end

  # * Return true if the user is either a Q-Auth Super Admin or Q-Auth Admin
  # == Examples
  #   >>> user.is_admin?
  #   => true
  def is_admin?
    user_type == 'admin' || user_type == 'super_admin'
  end

  # * Return true if the user is either a Q-Auth Admin
  # == Examples
  #   >>> user.is_super_admin?
  #   => true
  def is_super_admin?
    user_type == 'super_admin'
  end

  # * Return true if the user is not approved, else false.
  # * pending status will be there only for users who are not approved by user
  # == Examples
  #   >>> user.pending?
  #   => true
  def inactive?
    (status == ConfigCenter::User::INACTIVE)
  end

  # * Return true if the user is approved, else false.
  # == Examples
  #   >>> user.pending?
  #   => true
  def active?
    (status == ConfigCenter::User::ACTIVE)
  end

  # * Return true if the user is blocked, else false.
  # == Examples
  #   >>> user.blocked?
  #   => true
  def suspended?
    (status == ConfigCenter::User::SUSPEND)
  end

  # change the status to :pending
  # Return the status
  # == Examples
  #   >>> user.pending!
  #   => "pending"
  def inactive!
    self.update_attribute(:status, ConfigCenter::User::INACTIVE)
  end

  # change the status to :approve
  # Return the status
  # == Examples
  #   >>> user.approve!
  #   => "approved"
  def active!
    self.update_attribute(:status, ConfigCenter::User::ACTIVE)
  end

  # change the status to :approve
  # Return the status
  # == Examples
  #   >>> user.block!
  #   => "blocked"
  def suspend!
    self.update_attribute(:status, ConfigCenter::User::SUSPEND)
  end

  # Class variables
  class << self
    def find_for_database_authentication(condition = {})
      email = where("email = ?", condition['email'])
      email.first if email.present?
    end
  end

  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    FjMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while self.class.exists?(column => self[column])
  end

  def assign_default_password_if_nil
    self.password = ConfigCenter::Defaults::PASSWORD
    self.password_confirmation = ConfigCenter::Defaults::PASSWORD
  end

  private

  def generate_auth_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end

  def self.login(params)

    # Fetching the user data (email / username is case insensitive.)
    user = where("LOWER(email) = LOWER('#{params['login']}') OR LOWER(username) = LOWER('#{params['login']}')").first
    # If the user exists with the given username / password
    if user
      # Check if the user is not approved (pending, locked or blocked)
      # Will allow to login only if status is approved

      if user.status != ConfigCenter::User::ACTIVE
        heading = translate("authentication.error")
        alert = translate("authentication.user_is_#{@user.status.downcase}")
        raise AuthenticationError(alert: alert, heading: heading, data: user)
      # Check if the password matches
      # Invalid Login: Password / Username doesn't match
      elsif user.authenticate(params['password']) == false
        heading = translate("authentication.error")
        alert = translate("authentication.invalid_login")
        raise AuthenticationError(alert: alert, heading: heading, data: user)
      end
    # If the user with provided email doesn't exist
    else
      heading = translate("authentication.error")
      alert = translate("authentication.user_not_found")
      raise AuthenticationError(alert: alert, heading: heading, data: user)
    end
    return user

  end


  include StateMachinesScopes

end
