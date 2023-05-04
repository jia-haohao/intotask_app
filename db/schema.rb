ActiveRecord::Schema.define(version: 2023_05_04_064450) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.string "content"
    t.integer "priority"
    t.integer "status"
    t.date "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
