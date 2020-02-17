class CreateDataAndJoinTables < ActiveRecord::Migration[5.2]
  def change

    # Data Tables

    create_table :ingredients do |t|
      t.string :name
      t.integer :caloriespergram
      
      t.timestamps
    end

    create_table :ingredient_tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :equipment do |t|
      t.string :name

      t.timestamps
    end

    create_table :recipes do |t|
      t.string :name
      t.string :origin
      t.string :author
      t.integer :views
      t.integer :saves
      t.timestamps
    end

    create_table :recipe_types do |t|
      t.string :name
      t.timestamps
    end

    create_table :actions do |t|
      t.string :title
      t.text :body
      t.integer :order
      t.references :recipe
      t.timestamps
    end


    # Join Tables
    create_table :join_recipetypes_recipes do |t|
      t.references :recipe_type
      t.references :recipe
      t.timestamps
    end

    create_table :join_ingredienttags_ingredients do |t|
      t.references :ingredient_tag
      t.references :ingredient
      t.timestamps
    end

    create_table :join_ingredients_recipes do |t|
      t.integer :quantity_in_grams
      t.references :recipe
      t.references :ingredient
      t.timestamps
    end

    create_table :join_equipment_recipes do |t|
      t.references :equipment
      t.references :recipe
      t.timestamps
    end

  end
end
