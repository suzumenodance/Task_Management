class AddColor < ActiveRecord::Migration[5.2]
  def change
    add_column :icons, :color, :string
  end
end
