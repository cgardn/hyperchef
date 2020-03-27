class AddUnitsHashToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :units, :string, null: false, default: ""
  end
end
