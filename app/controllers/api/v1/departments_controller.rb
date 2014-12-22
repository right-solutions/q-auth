module Api
  module V1
    class DepartmentsController < Api::V1::BaseController

      skip_before_filter :require_auth_token
      before_filter :parse_pagination_params, only: :index

      def index
        proc_code = Proc.new do
          # Fetching the Designations
          relation = Department.where("")
          relation = relation.search(params[:query].strip) if params[:query] && !params[:query].blank?

          @data = relation.order("name asc").page(@current_page).per(@per_page)
          @success = true
        end
        render_json_response(proc_code)
      end

    end
  end
end