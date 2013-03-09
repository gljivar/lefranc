class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :language_object_id
      t.integer :translation_id

      t.timestamps
    end
  end
end
