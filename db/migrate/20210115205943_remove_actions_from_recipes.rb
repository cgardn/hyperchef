class RemoveActionsFromRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :actions, :string
  end
end
