class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :user_id
      t.string :image_filename
      t.string :short_blurb
      t.string :location
      t.integer :likes, :default => 0

      t.timestamps null: false
    end
  end
end
