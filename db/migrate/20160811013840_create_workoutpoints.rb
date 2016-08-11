class CreateWorkoutpoints < ActiveRecord::Migration
  def change
    create_table :workoutpoints do |t|
      t.integer :workout_point
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :workoutpoints, [:user_id, :created_at]
  end
end
