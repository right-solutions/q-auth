namespace :update_status do

  desc "Update user status"
  task :user_status => :environment do
    User.update_all(:status => 'inactive')
    p "udated"
  end
  
end