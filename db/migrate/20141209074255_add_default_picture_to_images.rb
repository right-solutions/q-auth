class AddDefaultPictureToImages < ActiveRecord::Migration
  def change
    add_column :images, :default_picture, :boolean, :default => true
  end
end
