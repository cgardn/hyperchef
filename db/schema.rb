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

ActiveRecord::Schema.define(version: 2020_02_17_014244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "equipment", force: :cascade do |t|
    t.string "name"
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

  create_table "recipe_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "origin"
    t.string "author"
    t.string "actions"
    t.integer "views"
    t.integer "saves"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
