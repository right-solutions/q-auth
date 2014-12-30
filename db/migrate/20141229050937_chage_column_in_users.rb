class ChageColumnInUsers < ActiveRecord::Migration
  def change
    change_column :users, :status, :string, :default => "inactive"
  end
end
