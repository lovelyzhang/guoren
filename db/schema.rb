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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170114044144) do

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "micro_post_id"
    t.datetime "comment_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "send_user"
    t.integer  "recieve_user"
    t.datetime "create_time"
    t.boolean  "readed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "micro_posts", force: :cascade do |t|
    t.text     "content"
    t.text     "pic"
    t.datetime "post_time"
    t.integer  "post_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id"
    t.integer  "engage_people"
    t.string   "title"
    t.text     "engaged_people_names"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "picurl"
    t.string   "profession"
    t.boolean  "sexual"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "verify_code"
  end

end
