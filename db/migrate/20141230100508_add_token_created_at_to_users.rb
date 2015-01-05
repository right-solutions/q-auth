class AddTokenCreatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token_created_at, :datetime, default: nil
  end
end
