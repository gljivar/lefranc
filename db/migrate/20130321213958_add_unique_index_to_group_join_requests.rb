class AddUniqueIndexToGroupJoinRequests < ActiveRecord::Migration
  def change

    add_index :group_join_requests, [:user_id, :group_id, :closed], :unique => true

  end
end
