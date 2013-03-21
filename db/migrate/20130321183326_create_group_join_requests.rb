class CreateGroupJoinRequests < ActiveRecord::Migration
  def change
    create_table :group_join_requests do |t|
      t.references :group_user
      t.references :user
      t.references :group
      t.integer :status
      t.boolean :closed

      t.timestamps
    end
    add_index :group_join_requests, :group_user_id
    add_index :group_join_requests, :user_id
    add_index :group_join_requests, :group_id
  end
end
