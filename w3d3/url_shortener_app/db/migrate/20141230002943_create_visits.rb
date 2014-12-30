class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visited_url_id
      t.integer :user_id
      t.timestamps
    end
  end
end
