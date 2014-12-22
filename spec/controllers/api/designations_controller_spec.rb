require "rails_helper"

RSpec.describe Api::V1::DesignationsController, :type => :controller do
  include ParamsParserHelper
  let(:designation){FactoryGirl.create(:designation)}
  let(:designation_one){FactoryGirl.create(:designation)}
  let(:designation_two){FactoryGirl.create(:designation)}
  let(:designation_three){FactoryGirl.create(:designation)}

  describe "GET #designations" do
    it "should return a list of designation" do
      [designation_one, designation_two, designation_three]

      get :index
      @data_1 = Designation.order("title asc").page(@current_page).per(@per_page).all
      expect(assigns[:data]).to match_array(@data_1)
    end
  end
  describe "GET #designation" do
    it "should return a designation" do
      get :show, :id => designation.id
      @data = Designation.where("id = ?", designation.id)
      binding.pry
      expect(assigns[:data]).to eq(@data.first)
    end
  end
end