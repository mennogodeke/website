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

ActiveRecord::Schema[8.1].define(version: 2026_05_10_213924) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cv_downloads", force: :cascade do |t|
    t.datetime "approved_at"
    t.datetime "created_at", null: false
    t.integer "download_count"
    t.string "email"
    t.datetime "last_download_at"
    t.datetime "requested_at"
    t.string "token"
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_cv_downloads_on_token", unique: true
  end

  create_table "expertise_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "expertise_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["expertise_id"], name: "index_expertise_skills_on_expertise_id"
    t.index ["skill_id"], name: "index_expertise_skills_on_skill_id"
  end

  create_table "expertises", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "years_of_experience"
  end

  create_table "job_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_skills_on_job_id"
    t.index ["skill_id"], name: "index_job_skills_on_skill_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "company"
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.date "start_date"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "project_skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "project_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_skills_on_project_id"
    t.index ["skill_id"], name: "index_project_skills_on_skill_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.integer "position"
    t.string "repo_url"
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "year"
  end

  create_table "skills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "level"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expertise_skills", "expertises"
  add_foreign_key "expertise_skills", "skills"
  add_foreign_key "job_skills", "jobs"
  add_foreign_key "job_skills", "skills"
  add_foreign_key "project_skills", "projects"
  add_foreign_key "project_skills", "skills"
end
