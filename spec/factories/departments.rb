FactoryGirl.define do
  factory :department, class: "Department" do
    name "Accounts and Finance"
    description "Test data"
    association :picture, :factory => :department_picture
    after_create do |department|
      5.times {department.users << FactoryGirl.create(:user)}
    end
  end
end