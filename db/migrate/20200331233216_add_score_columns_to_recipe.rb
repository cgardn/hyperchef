class AddScoreColumnsToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :time_score, :integer, null: false, default: 0
    add_column :recipes, :ingredient_score, :integer, null: false, default: 0
  end
end
