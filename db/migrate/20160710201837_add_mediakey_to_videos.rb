class AddMediakeyToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :mediakey, :string
  end
end
