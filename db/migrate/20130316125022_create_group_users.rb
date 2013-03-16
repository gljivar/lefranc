class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.references :user
      t.references :group

      t.timestamps
    end
    add_index :group_users, :user_id
    add_index :group_users, :group_id
  end
end
