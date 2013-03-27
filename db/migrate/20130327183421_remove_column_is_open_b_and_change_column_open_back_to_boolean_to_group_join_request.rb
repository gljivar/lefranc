class RemoveColumnIsOpenBAndChangeColumnOpenBackToBooleanToGroupJoinRequest < ActiveRecord::Migration
  def up
    remove_column :group_join_requests, :is_open_b
    change_column :group_join_requests, :open, :boolean, :default => true, :nil => false
  end

  def down
    add_column :group_join_requests, :is_open_b, :default => false, :nil => false
    change_column :group_join_requests, :open, :integer, :default => 0, :nil => false
  end
end
