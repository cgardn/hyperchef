class AddLiquidBoolToJoinIngredientsRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :is_liquid, :boolean, default: false
  end
end
