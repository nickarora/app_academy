class CreatePostsubs < ActiveRecord::Migration
  def change
    create_table :postsubs do |t|
      t.integer :sub_id, null: false, index: true
      t.integer :post_id, null: false, index: true
      t.timestamps null: false
    end

    remove_column :posts, :sub_id
  end
end
