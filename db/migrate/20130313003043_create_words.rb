class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.references :word_gender

      t.timestamps
    end
    add_index :words, :word_gender_id
  end
end
