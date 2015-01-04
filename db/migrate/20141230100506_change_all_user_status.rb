class ChangeAllUserStatus < ActiveRecord::Migration
  def change
  	User.where(:status => "pending" ).update_all(:status => "inactive")
    User.where(:status => "approved" ).update_all(:status => "active")
    User.where(:status => "blocked" ).update_all(:status => "suspended")
  end
end
