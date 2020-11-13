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

ActiveRecord::Schema.define(version: 2020_11_13_025346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.string "affiliate_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredient_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "caloriespergram"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_liquid", default: false
    t.string "units", default: "", null: false
  end

  create_table "join_equipment_recipes", force: :cascade do |t|
    t.bigint "equipment_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_join_equipment_recipes_on_equipment_id"
    t.index ["recipe_id"], name: "index_join_equipment_recipes_on_recipe_id"
  end

  create_table "join_ingredients_recipes", force: :cascade do |t|
    t.integer "quantity_in_grams"
    t.bigint "recipe_id"
    t.bigint "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_join_ingredients_recipes_on_ingredient_id"
    t.index ["recipe_id"], name: "index_join_ingredients_recipes_on_recipe_id"
  end

  create_table "join_ingredienttags_ingredients", force: :cascade do |t|
    t.bigint "ingredient_tag_id"
    t.bigint "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_join_ingredienttags_ingredients_on_ingredient_id"
    t.index ["ingredient_tag_id"], name: "index_join_ingredienttags_ingredients_on_ingredient_tag_id"
  end

  create_table "join_recipetypes_recipes", force: :cascade do |t|
    t.bigint "recipe_type_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_join_recipetypes_recipes_on_recipe_id"
    t.index ["recipe_type_id"], name: "index_join_recipetypes_recipes_on_recipe_type_id"
  end

  create_table "join_userprofiles_recipes", force: :cascade do |t|
    t.bigint "user_profile_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_join_userprofiles_recipes_on_recipe_id"
    t.index ["user_profile_id"], name: "index_join_userprofiles_recipes_on_user_profile_id"
  end

  create_table "recipe_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "origin"
    t.string "author"
    t.string "actions"
    t.integer "views"
    t.integer "saves"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "card_image_path", default: "", null: false
    t.integer "cook_time", default: 0, null: false
    t.integer "prep_time", default: 0, null: false
    t.integer "difficulty", default: 1, null: false
    t.integer "time_score", default: 0, null: false
    t.integer "ingredient_score", default: 0, null: false
    t.index ["slug"], name: "index_recipes_on_slug", unique: true
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
