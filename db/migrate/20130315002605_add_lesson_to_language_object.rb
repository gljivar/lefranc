class AddLessonToLanguageObject < ActiveRecord::Migration
  def change
   add_column :language_objects, :lesson_id, :integer

  end
end
