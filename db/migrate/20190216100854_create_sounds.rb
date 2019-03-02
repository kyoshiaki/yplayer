class CreateSounds < ActiveRecord::Migration[5.2]
  def change
    create_table :sounds do |t|
      t.string :path
      t.string :name
      t.boolean :listened
      t.integer :playhead
      t.boolean :marked
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
