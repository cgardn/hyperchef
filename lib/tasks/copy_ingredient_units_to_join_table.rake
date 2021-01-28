namespace :ingredient_units do
  desc "Copies 'units' hash from Ingredient model to JoinIngredientsRecipes model"
  task :copy => :environment do
    Ingredient.all.each do |ing|
      puts "Copying #{ing.name}, id: #{ing.id}"
      ing.join_ingredients_recipes.each do |ir|
        ir.show_quantity = ing.units['metric_show'][0]
        ir.show_unit = ing.units['metric_show'][1]
        ir.list_quantity = ing.units['metric_list'][0]
        ir.list_unit = ing.units['metric_list'][1]
        ir.save
      end
    end
  end
end
# probably just copy whatever the metric is and start doing conversions on frontend, less stuff to update
