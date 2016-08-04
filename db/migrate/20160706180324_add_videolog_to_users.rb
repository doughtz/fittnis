class AddVideologToUsers < ActiveRecord::Migration
  def change
    add_column :users, :videolog, :string, array: true, default: []
  end
end
