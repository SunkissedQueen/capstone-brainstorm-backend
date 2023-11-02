class CreateBlockers < ActiveRecord::Migration[7.0]
  def change
    create_table :blockers do |t|
      t.text :category
      t.text :blocker_description
      t.text :image1
      t.text :image2
      t.text :image3
      t.boolean :resolved
      t.boolean :urgent

      t.timestamps
    end
  end
end
