class AddIngredientTagsToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :ingredientTags, :text, array: true, default: []
  end
end
