class CreateWorkoutsecs < ActiveRecord::Migration
  def change
    create_table :workoutsecs do |t|
      t.integer :workout_secs
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
