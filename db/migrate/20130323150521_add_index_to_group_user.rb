class AddIndexToGroupUser < ActiveRecord::Migration
  def change
    add_index :group_users, [:group_id, :user_id], :unique => true
  end
end
