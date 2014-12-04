require 'spec_helper'

RSpec.describe Designation, :type => :model do
  let(:designation) {FactoryGirl.build(:designation)}

  context "Factory settings for report" do
    it "should validate the report factories" do
      expect(FactoryGirl.build(:designation).valid?).to be true
    end
  end

  describe Designation do
    it { should validate_presence_of :title }
    it { should validate_presence_of :responsibilities }
    it { should allow_value('title').for(:title )}
    it { should allow_value('Test Data').for(:responsibilities )}
  end

  it "should search the designation" do
    value = "Title"
    search = value.downcase
    data = Designation.where("title.downcase = ?", search).all || Designation.where("responsibilities.downcase = ?", search).all
    expect(data).to be_truthy
  end
end