class CreateIcons < ActiveRecord::Migration[5.2]
  def change
    create_table :icons do |t|
      t.string :name
      t.string :image_path
      t.integer :user_id

      t.timestamps
    end
  end
end
