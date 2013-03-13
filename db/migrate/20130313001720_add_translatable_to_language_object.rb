class AddTranslatableToLanguageObject < ActiveRecord::Migration
  def change
   add_column :language_objects, :translatable_id, :integer
   add_column :language_objects, :translatable_type, :string 

  end
end
