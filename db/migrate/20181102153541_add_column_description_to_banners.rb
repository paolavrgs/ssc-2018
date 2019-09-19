class AddColumnDescriptionToBanners < ActiveRecord::Migration[5.2]
  def change
    add_column :banners, :description, :text
  end
end
