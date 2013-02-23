class CreateWordGenders < ActiveRecord::Migration
  def change
    create_table :word_genders do |t|
      t.string :name
      t.string :short_name
      t.integer :language_id

      t.timestamps
    end
  end
end
