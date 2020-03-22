class AddDifficultyToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :difficulty, :integer, null: false, default: 1
  end
end
