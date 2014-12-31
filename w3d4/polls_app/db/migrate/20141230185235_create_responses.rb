class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :responder_id
      t.integer :answer_choice_id
      t.timestamps null: false
    end

    add_index :responses, :responder_id
    add_index :responses, :answer_choice_id
  end
end
