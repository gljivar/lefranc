class AddNativeAndForeignLanguageToGroup < ActiveRecord::Migration
  def change
   add_column :groups, :native_language_id, :integer
   add_column :groups, :foreign_language_id, :integer
  end
end
