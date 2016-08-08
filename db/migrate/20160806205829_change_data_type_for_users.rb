class ChangeDataTypeForUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :calories, :float
    end
  end

  def self.down
    change_table :users do |t|
      t.change :calories, :integer
    end
  end
end

