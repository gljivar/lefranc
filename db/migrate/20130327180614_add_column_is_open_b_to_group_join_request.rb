class AddColumnIsOpenBToGroupJoinRequest < ActiveRecord::Migration
  def change
    add_column :group_join_requests, :is_open_b, :boolean, :default => false, :null => false
  end
end
