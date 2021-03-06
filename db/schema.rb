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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160903022745) do

  create_table "calspersecs", force: :cascade do |t|
    t.float    "calories_persec"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "calspersecs", ["user_id"], name: "index_calspersecs_on_user_id"

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"
  add_index "microposts", ["video_id", "created_at"], name: "index_microposts_on_video_id_and_created_at"
  add_index "microposts", ["video_id"], name: "index_microposts_on_video_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.float    "calories"
    t.integer  "workouts"
    t.integer  "workoutseconds"
    t.string   "videolog",          default: "--- []\n"
    t.string   "time_zone"
    t.string   "uid"
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "videos", force: :cascade do |t|
    t.text     "title"
    t.integer  "user_id"
    t.text     "description"
    t.integer  "length"
    t.text     "tags"
    t.text     "equipment"
    t.text     "videofile"
    t.integer  "rating"
    t.text     "categor"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "calories"
    t.integer  "workouts"
    t.integer  "workoutseconds"
    t.string   "videolog",       default: "--- []\n"
    t.string   "mediakey"
  end

  add_index "videos", ["user_id", "created_at"], name: "index_videos_on_user_id_and_created_at"
  add_index "videos", ["user_id"], name: "index_videos_on_user_id"

  create_table "workoutpoints", force: :cascade do |t|
    t.integer  "workout_point"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "workoutpoints", ["user_id", "created_at"], name: "index_workoutpoints_on_user_id_and_created_at"
  add_index "workoutpoints", ["user_id"], name: "index_workoutpoints_on_user_id"

  create_table "workoutsecs", force: :cascade do |t|
    t.integer  "workout_secs"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "workoutsecs", ["user_id"], name: "index_workoutsecs_on_user_id"

end
