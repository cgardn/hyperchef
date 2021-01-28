class AddUnitsToJoinIngredientsRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :join_ingredients_recipes, :show_quantity, :decimal, :precision=>10, :scale=>3, null: false, default: 0
    add_column :join_ingredients_recipes, :show_unit, :string, null: false, default: "g"
    add_column :join_ingredients_recipes, :list_quantity, :decimal, :precision=>10, :scale=>3, null: false, default: 0
    add_column :join_ingredients_recipes, :list_unit, :string, null: false, default: "g"
    remove_column :join_ingredients_recipes, :quantity_in_grams
  end
end
