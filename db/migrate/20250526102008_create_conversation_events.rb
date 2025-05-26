class CreateConversationEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :conversation_events do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :type, null: false
      t.text :body
      t.integer :prev_status
      t.integer :new_status

      t.timestamps
    end

    add_index :conversation_events, :type
    add_index :conversation_events, :created_at
  end
end
