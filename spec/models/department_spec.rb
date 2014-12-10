require 'spec_helper'

RSpec.describe Department, :type => :model do
  let(:department) {FactoryGirl.build(:department)}

  context "Factory settings for department" do
    it "should validate the department factories" do
      expect(FactoryGirl.build(:department).valid?).to be true
    end
  end

  describe Department do
    it { should validate_presence_of :name }
    it { should allow_value('Testing').for(:name)}

    it "should search the department" do
      Department.create(:name =>"HR", :description =>"Test data");
      expect(Department.search("Test data")).to be_truthy
      expect(Department.search("Some data")).to be_empty
    end
  end
end