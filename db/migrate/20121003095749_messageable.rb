class Messageable < ActiveRecord::Migration
  def change
    add_column :messages, :wedding_id, :integer
    add_column :messages, :messageable_id, :integer
    add_column :messages, :messageable_type, :string

    execute <<EOL
UPDATE messages AS m
  SET messageable_type = 'Guest',
      messageable_id = m.guest_id,
      wedding_id = g.wedding_id
FROM guests AS g
WHERE m.guest_id = g.id
EOL

    change_column :messages, :wedding_id, :integer, null: false
    change_column :messages, :messageable_id, :integer, null: false
    change_column :messages, :messageable_type, :string, null: false

    remove_column :messages, :guest_id
    remove_column :guests, :messages_count

    add_index :messages, :wedding_id
    add_index :messages, :messageable_id
    add_index :messages, :messageable_type
  end
end
