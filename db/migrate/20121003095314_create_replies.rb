class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :text

      t.references :message, null: false
      t.references :replyable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :replies, :message_id
    add_index :replies, :replyable_id
    add_index :replies, :replyable_type
  end
end
