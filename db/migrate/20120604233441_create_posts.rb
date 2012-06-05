class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body
      t.string :slug
      t.boolean :published, default: false

      t.references :author

      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :slug, unique: true
  end
end
