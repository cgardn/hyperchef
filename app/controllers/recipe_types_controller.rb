class RecipeTypesController < ApplicationController

  def index
    alltypes = RecipeType.all
    counts = []
    alltypes.count.times do |n|
      counts[n] = alltypes[n].recipes.count
    end
    @types = [alltypes.count, alltypes, counts]
  end
end
