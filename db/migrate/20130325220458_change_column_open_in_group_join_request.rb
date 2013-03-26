class ChangeColumnOpenInGroupJoinRequest < ActiveRecord::Migration
  def up
    change_column(:group_join_requests, :open, :boolean, :default => false, :null => false)
  end

  def down
    change_column(:group_join_requests, :open, :boolean)
  end
end
