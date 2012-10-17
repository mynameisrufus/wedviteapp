class Messageable < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.references :wedding, null: false
      t.references :messageable, polymorphic: true, null: false
    end

    execute <<EOL
UPDATE messages AS m
  SET messageable_type = 'Guest',
      messageable_id = m.guest_id,
      wedding_id = g.wedding_id
FROM guests AS g
WHERE m.guest_id = g.id
EOL

    change_table :messages do |t|
      t.remove :guest_id
    end

    change_table :guests do |t|
      t.remove :messages_count
    end

    add_index :messages, :wedding_id
    add_index :messages, :messageable_id
    add_index :messages, :messageable_type
  end
end
