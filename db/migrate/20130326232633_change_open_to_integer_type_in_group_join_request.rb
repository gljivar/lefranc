class ChangeOpenToIntegerTypeInGroupJoinRequest < ActiveRecord::Migration
  def up
    change_column :group_join_requests, :open, :integer
  end

  def down
    change_column :group_join_requests, :open, :boolean, :null => :false
  end
end
