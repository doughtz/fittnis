class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :title
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.integer :length
      t.text :tags
      t.text :equipment
      t.text :videofile
      t.integer :rating
      t.text :categor

      t.timestamps null: false
    end
    add_index :videos, [:user_id, :created_at]
  end
end
