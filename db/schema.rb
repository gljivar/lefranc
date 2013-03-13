# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130313003043) do

  create_table "language_objects", :force => true do |t|
    t.integer  "language_id"
    t.integer  "user_id"
    t.string   "text"
    t.string   "meaning"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "translatable_id"
    t.string   "translatable_type"
  end

  add_index "language_objects", ["language_id"], :name => "index_language_objects_on_language_id"
  add_index "language_objects", ["user_id"], :name => "index_language_objects_on_user_id"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "english_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "person_genders", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "translations", :force => true do |t|
    t.integer  "language_object_id"
    t.integer  "translation_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "word_genders", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "language_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "words", :force => true do |t|
    t.integer  "word_gender_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "words", ["word_gender_id"], :name => "index_words_on_word_gender_id"

end
