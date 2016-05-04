class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :user_id
      t.string :image_filename
      t.string :short_description
      t.string :long_description

      t.timestamps null: false
    end
  end
end
