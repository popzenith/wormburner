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

ActiveRecord::Schema.define(version: 81) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: true do |t|
    t.integer  "facility_id"
    t.string   "course_code"
    t.string   "facility_code"
    t.string   "course_name"
    t.string   "hol"
    t.string   "par"
    t.string   "course_type"
    t.string   "course_architect"
    t.string   "open_date"
    t.string   "guest_policy"
    t.string   "weekday_price"
    t.string   "weekend_price"
    t.string   "twilight_price"
    t.string   "fairway"
    t.string   "green"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["created_at"], name: "index_courses_on_created_at", using: :btree

  create_table "events", force: true do |t|
    t.integer  "course_id"
    t.string   "complete"
    t.date     "playdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["course_id"], name: "index_events_on_course_id", using: :btree

  create_table "facilities", force: true do |t|
    t.string   "facility_code"
    t.string   "facility_name"
    t.string   "club_membership"
    t.string   "number_of_holes"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "contact_name"
    t.string   "contact_title"
    t.string   "email_address"
    t.string   "driving_range"
    t.string   "putting_green"
    t.string   "chipping_green"
    t.string   "practice_bunker"
    t.string   "motor_cart"
    t.string   "pull_cart"
    t.string   "golf_clubs_rental"
    t.string   "club_fitting"
    t.string   "pro_shop"
    t.string   "golf_lessons"
    t.string   "caddie_hire"
    t.string   "restaurant"
    t.string   "reception_hall"
    t.string   "changing_room"
    t.string   "lockers"
    t.string   "lodging_on_site"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facilities", ["created_at"], name: "index_facilities_on_created_at", using: :btree

  create_table "holes", force: true do |t|
    t.integer  "round_id"
    t.string   "hole_number"
    t.integer  "score_total"
    t.integer  "strikes"
    t.integer  "putts"
    t.integer  "penalty"
    t.string   "fairway"
    t.string   "green"
    t.string   "sand"
    t.string   "scramble"
    t.string   "holepar"
    t.string   "holehandicap"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "holes", ["round_id"], name: "index_holes_on_round_id", using: :btree

  create_table "microposts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree

  create_table "promos", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "content"
    t.string   "link"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promos", ["user_id"], name: "index_promos_on_user_id", using: :btree

  create_table "reservations", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["user_id", "course_id"], name: "index_reservations_on_user_id_and_course_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "rounds", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "scorecard_id"
    t.string   "tee"
    t.integer  "score_front"
    t.integer  "score_back"
    t.integer  "score_total"
    t.string   "handicap_used"
    t.string   "complete"
    t.date     "playdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rounds", ["event_id"], name: "index_rounds_on_event_id", using: :btree

  create_table "scorecards", force: true do |t|
    t.integer  "course_id"
    t.string   "tee_id"
    t.string   "course_code"
    t.string   "tee_name"
    t.string   "tee_color"
    t.string   "course_par_for_tee"
    t.string   "hole1"
    t.string   "hole2"
    t.string   "hole3"
    t.string   "hole4"
    t.string   "hole5"
    t.string   "hole6"
    t.string   "hole7"
    t.string   "hole8"
    t.string   "hole9"
    t.string   "hole10"
    t.string   "hole11"
    t.string   "hole12"
    t.string   "hole13"
    t.string   "hole14"
    t.string   "hole15"
    t.string   "hole16"
    t.string   "hole17"
    t.string   "hole18"
    t.string   "total_distance"
    t.string   "hole1_par"
    t.string   "hole2_par"
    t.string   "hole3_par"
    t.string   "hole4_par"
    t.string   "hole5_par"
    t.string   "hole6_par"
    t.string   "hole7_par"
    t.string   "hole8_par"
    t.string   "hole9_par"
    t.string   "hole10_par"
    t.string   "hole11_par"
    t.string   "hole12_par"
    t.string   "hole13_par"
    t.string   "hole14_par"
    t.string   "hole15_par"
    t.string   "hole16_par"
    t.string   "hole17_par"
    t.string   "hole18_par"
    t.string   "hole1_handicap"
    t.string   "hole2_handicap"
    t.string   "hole3_handicap"
    t.string   "hole4_handicap"
    t.string   "hole5_handicap"
    t.string   "hole6_handicap"
    t.string   "hole7_handicap"
    t.string   "hole8_handicap"
    t.string   "hole9_handicap"
    t.string   "hole10_handicap"
    t.string   "hole11_handicap"
    t.string   "hole12_handicap"
    t.string   "hole13_handicap"
    t.string   "hole14_handicap"
    t.string   "hole15_handicap"
    t.string   "hole16_handicap"
    t.string   "hole17_handicap"
    t.string   "hole18_handicap"
    t.string   "rating"
    t.string   "slope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scorecards", ["created_at"], name: "index_scorecards_on_created_at", using: :btree

  create_table "user_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_events", ["user_id", "event_id"], name: "index_user_events_on_user_id_and_event_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "name",                              default: "", null: false
    t.string   "encrypted_password",                default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token",       limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "notify"
    t.string   "handicap"
    t.string   "buddy"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
