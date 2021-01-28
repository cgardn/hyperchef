class RemoveIngredientTagsFromRecipe < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :ingredientTags, :text
  end
end
