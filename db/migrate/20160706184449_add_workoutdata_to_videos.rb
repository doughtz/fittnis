class AddWorkoutdataToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :calories, :integer
    add_column :videos, :workouts, :integer
    add_column :videos, :workoutseconds, :integer
    add_column :videos, :videolog, :string, array: true, default: []
  end
end
