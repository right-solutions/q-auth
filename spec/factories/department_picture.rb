FactoryGirl.define do
  factory :department_picture, :class => Image::DepartmentPicture do
    image { Rack::Test::UploadedFile.new('test/fixtures/test.jpg', 'image/jpg') }
  end
end