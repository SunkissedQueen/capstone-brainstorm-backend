class CreateSolutions < ActiveRecord::Migration[7.0]
  def change
    create_table :solutions do |t|
      t.text :description
      t.text :image1
      t.text :image2
      t.text :image3
      t.boolean :require_followup
      t.boolean :attempted
      t.boolean :acceptable
      t.integer :user_id
      t.integer :blocker_id

      t.timestamps
    end
  end
end
