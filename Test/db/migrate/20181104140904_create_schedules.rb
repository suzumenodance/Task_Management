class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.datetime :start_date
      t.datetime :finish_date
      t.integer :user_id
      t.integer :icon_id

      t.timestamps
    end
  end
end
