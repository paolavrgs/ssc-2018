class CreateDownloads < ActiveRecord::Migration[5.2]
  def change
    create_table :downloads do |t|
      t.string :title
      t.text :description
      t.string :file
      t.integer :position

      t.timestamps
    end
  end
end
