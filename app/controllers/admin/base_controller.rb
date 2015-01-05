class Admin::BaseController < ApplicationController

  layout 'admin'

  before_filter :require_user, :require_admin, :set_navs, :parse_pagination_params

end
