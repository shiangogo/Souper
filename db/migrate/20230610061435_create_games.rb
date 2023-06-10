class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.text :whole_story
      t.integer :difficulty, null: true

      t.timestamps
    end
  end
end
