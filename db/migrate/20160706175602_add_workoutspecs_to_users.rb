class AddWorkoutspecsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :calories, :integer
    add_column :users, :workouts, :integer
    add_column :users, :workoutseconds, :integer
  end
end
