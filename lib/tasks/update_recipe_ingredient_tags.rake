namespace :update_recipe_ingredient_tags do
  desc "Denormalizes ingredient tags onto Recipe Table"
  task :denormalize => :environment do
    Recipe.all.each do |r|
      it = IngredientTag.joins(ingredients: :recipes).where("recipe_id = ?", r.id).pluck(:name).to_set.to_a
      r.ingredientTags = it
      r.save
      p r.ingredientTags
    end
  end
end
