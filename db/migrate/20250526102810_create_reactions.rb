class CreateReactions < ActiveRecord::Migration[8.0]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reaction_type, null: false
      t.references :reactable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :reactions, [:user_id, :reactable_type, :reactable_id], unique: true, name: "index_reactions_on_user_and_reactable"
  end
end
