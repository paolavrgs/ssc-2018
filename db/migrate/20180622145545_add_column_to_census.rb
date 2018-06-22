class AddColumnToCensus < ActiveRecord::Migration[5.2]
  def change
    add_column :census, :jefe_familia, :boolean
  end
end
