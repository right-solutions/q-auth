require "rails_helper"

RSpec.describe Api::V1::DepartmentsController, :type => :controller do
  include ParamsParserHelper
  let(:department){FactoryGirl.create(:department)}
  let(:department_one){FactoryGirl.create(:department)}
  let(:department_two){FactoryGirl.create(:department)}
  let(:department_three){FactoryGirl.create(:department)}

  describe "GET #departments" do
    it "should return a list of departments" do
      [department_one, department_two, department_three]

      get :index
      @data = Department.order("name asc").page(@current_page).per(@per_page).all
      expect(assigns[:data]).to match_array(@data)
    end
  end
end
