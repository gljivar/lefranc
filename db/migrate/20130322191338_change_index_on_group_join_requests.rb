class ChangeIndexOnGroupJoinRequests < ActiveRecord::Migration
  def up
    remove_index :group_join_requests, :column => [:user_id, :group_id, :closed]
    add_index :group_join_requests, [:user_id, :group_id, :closed, :status], :unique => true, :name => "index_group_join_requests_u_g_c_s"
  end

  def down
    remove_index :group_join_requests, :column => [:user_id, :group_id, :closed, :status]
    add_index :group_join_requests, [:user_id, :group_id, :closed], :unique => true
  end
end
