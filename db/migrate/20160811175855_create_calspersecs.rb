class CreateCalspersecs < ActiveRecord::Migration
  def change
    create_table :calspersecs do |t|
      t.float :calories_persec
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
