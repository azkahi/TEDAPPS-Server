# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_05_023310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "scores", force: :cascade do |t|
    t.integer "score"
    t.float "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "score_type"
    t.string "username"
    t.datetime "start_time"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "participant_type"
    t.text "favourite_session"
    t.text "favourite_speaker"
    t.text "favourite_moderator"
    t.text "new_cap"
    t.text "reason_new_cap"
    t.string "satisfaction"
    t.text "suggestion"
    t.text "next_session_suggestion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "user_type"
    t.string "expertise"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
