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

    Designation.create(:title =>"Developer", :responsibilities =>"Test data");
    Designation.create(:title =>"Tester", :responsibilities =>"Test data1");
    Designation.create(:title =>"Designer", :responsibilities =>"Test data2");
    Designation.create(:title =>"Architect", :responsibilities =>"Test data3");
    expect(Designation.search("Test data")).to be_truthy
    expect(Designation.search("Some data")).to be_empty
  end
end