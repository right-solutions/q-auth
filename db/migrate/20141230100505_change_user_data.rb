class ChangeUserData < ActiveRecord::Migration
  def change
  	change_column :users, :user_type, :string, :default => "user"
  	User.where(:user_type => "" ).update_all(:user_type => "user")
  	User.update_all(:status => 'inactive')
  end
end
