class AddCardImagePathToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :card_image_path, :string, null: false, default: ""
  end
end
