class CreateCensus < ActiveRecord::Migration[5.2]
  def change
    create_table :census do |t|
      t.string :name
      t.string :last_name
      t.string :calle
      t.string :casa
      t.string :piso
      t.string :edad
      t.string :sector
      t.date :birthdate
      t.string :profesion
      t.string :nivel_estudio
      t.integer :position

      t.timestamps
    end
  end
end
