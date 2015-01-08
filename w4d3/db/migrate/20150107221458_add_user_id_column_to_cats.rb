class AddUserIdColumnToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer, null: false
    add_index  :cats, :user_id
    add_foreign_key :cats, :users
  end
end
