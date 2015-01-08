class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :session_tokens do |t|
      t.string  :token, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :session_tokens, :token
    add_index :session_tokens, :user_id
    add_foreign_key :session_tokens, :users

  end
end
