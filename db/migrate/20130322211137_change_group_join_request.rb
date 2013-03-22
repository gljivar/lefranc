class ChangeGroupJoinRequest < ActiveRecord::Migration
  def up
    rename_column :group_join_requests, :closed, :open
  end

  def down
    rename_column :group_join_requests, :open, :closed
  end
end
