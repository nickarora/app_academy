class AddUserIdtoCatRequests < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, null: false
    add_index  :cat_rental_requests, :user_id
    add_foreign_key :cat_rental_requests, :users
  end
end
