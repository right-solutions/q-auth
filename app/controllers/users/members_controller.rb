module Users
  class MembersController < Users::BaseController
    def index

      get_collections

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
        format.js {}
      end
    end

    def show
      ## Creating the designation object
      @user = User.find(params[:id])

      respond_to do |format|
        format.html { render :show }
        format.js {}
      end
    end

    def set_navs
      set_nav("users/members")
    end

    private

    def get_collections
      # Fetching the users
      relation = User.where("")
      @filters = {}
      if params[:query]
        @query = params[:query].strip
        relation = relation.search(@query) if !@query.blank?
      end

      @per_page = params[:per_page] || "21"
      @users = relation.order("name asc").page(@current_page).per(@per_page)

      ## Initializing the @user object so that we can render the show partial
      @user = @users.first unless @user

      return true

    end
  end
end