class AddActionArrayToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :action_array, :string
  end
end
