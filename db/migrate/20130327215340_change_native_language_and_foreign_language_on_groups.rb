class ChangeNativeLanguageAndForeignLanguageOnGroups < ActiveRecord::Migration
  def up
    change_column :groups, :foreign_language_id, :integer, :null => false
    change_column :groups, :native_language_id, :integer, :null => false
  end

  def down
    change_column :groups, :foreign_language_id, :integer
    change_column :groups, :native_language_id, :integer
  end
end
