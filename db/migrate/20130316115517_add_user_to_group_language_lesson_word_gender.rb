class AddUserToGroupLanguageLessonWordGender < ActiveRecord::Migration
  def change
   add_column :groups, :user_id, :integer
   add_column :languages, :user_id, :integer
   add_column :lessons, :user_id, :integer 
   add_column :word_genders, :user_id, :integer

  end
end
