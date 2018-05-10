class AddColumnPositionToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :position, :integer
  end
end
