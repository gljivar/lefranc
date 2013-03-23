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

ActiveRecord::Schema.define(:version => 20130323150521) do

  create_table "group_join_requests", :force => true do |t|
    t.integer  "group_user_id"
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "status"
    t.boolean  "open"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "group_join_requests", ["group_id"], :name => "index_group_join_requests_on_group_id"
  add_index "group_join_requests", ["group_user_id"], :name => "index_group_join_requests_on_group_user_id"
  add_index "group_join_requests", ["user_id"], :name => "index_group_join_requests_on_user_id"

  create_table "group_join_responses", :force => true do |t|
    t.integer  "group_join_request_id"
    t.integer  "user_id"
    t.integer  "response"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "group_join_responses", ["group_join_request_id"], :name => "index_group_join_responses_on_group_join_request_id"
  add_index "group_join_responses", ["user_id"], :name => "index_group_join_responses_on_user_id"

  create_table "group_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "group_users", ["group_id", "user_id"], :name => "index_group_users_on_group_id_and_user_id", :unique => true
  add_index "group_users", ["group_id"], :name => "index_group_users_on_group_id"
  add_index "group_users", ["user_id"], :name => "index_group_users_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "native_language_id"
    t.integer  "foreign_language_id"
    t.integer  "user_id"
  end

  create_table "language_objects", :force => true do |t|
    t.integer  "language_id"
    t.integer  "user_id"
    t.string   "text"
    t.string   "meaning"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "translatable_id"
    t.string   "translatable_type"
    t.integer  "lesson_id"
  end

  add_index "language_objects", ["language_id"], :name => "index_language_objects_on_language_id"
  add_index "language_objects", ["user_id"], :name => "index_language_objects_on_user_id"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "english_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "lessons", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
    t.integer  "user_id"
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
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "email"
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "description"
    t.string   "image"
    t.string   "phone"
    t.string   "token"
    t.string   "secret"
  end

  create_table "word_genders", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "language_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "words", :force => true do |t|
    t.integer  "word_gender_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "words", ["word_gender_id"], :name => "index_words_on_word_gender_id"

end
