class CreateSubscribes < ActiveRecord::Migration
  def change
    create_table :subscribes do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :subscribes, :event_id
    add_index :subscribes, :user_id
    add_index :subscribes, [:event_id, :user_id], unique: true

  end
end
