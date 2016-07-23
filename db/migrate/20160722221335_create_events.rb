class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :venue
      t.string :pic
      t.datetime :starts_at, :null => false, :default => Time.now
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
