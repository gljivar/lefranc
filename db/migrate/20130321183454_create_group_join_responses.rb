class CreateGroupJoinResponses < ActiveRecord::Migration
  def change
    create_table :group_join_responses do |t|
      t.references :group_join_request
      t.references :user
      t.integer :response

      t.timestamps
    end
    add_index :group_join_responses, :group_join_request_id
    add_index :group_join_responses, :user_id
  end
end
