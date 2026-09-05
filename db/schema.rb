# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_03_29_162101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mlb_teams", comment: "MLBのチーム", force: :cascade do |t|
    t.string "name", comment: "チーム名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", comment: "選手", force: :cascade do |t|
    t.bigint "mlb_team_id", null: false, comment: "所属チーム"
    t.string "name", comment: "選手名"
    t.boolean "is_injured", comment: "故障者であるか否か（故障者であればtrue）"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mlb_team_id"], name: "index_players_on_mlb_team_id"
  end

  add_foreign_key "players", "mlb_teams"
end
