class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :name
      t.integer :dni
      t.text :address
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
