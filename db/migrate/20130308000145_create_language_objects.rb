class CreateLanguageObjects < ActiveRecord::Migration
  def change
    create_table :language_objects do |t|
      t.references :language
      t.references :user
      t.string :text
      t.string :meaning

      t.timestamps
    end
    add_index :language_objects, :language_id
    add_index :language_objects, :user_id
  end
end
