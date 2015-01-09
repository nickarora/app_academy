class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
    	t.string :name, null: false
    	t.string :version, null: false
    	t.text :lyrics
    	t.integer :album_id, null: false
      t.timestamps null: false
    end

    add_index :tracks, :album_id
    add_foreign_key :tracks, :albums
  end
end
