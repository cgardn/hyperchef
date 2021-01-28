require 'rails_helper'

RSpec.describe Api::V1::RecipesController do

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected FilterGraph attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array([
        "all_filters", "all_recipes", "sorted_recipe_ids"
      ])
    end
  end

  describe "GET #show" do
    before do
      get :show, params: {slug: recipe.slug}
    end

    let (:recipe) { Recipe.create(name: 'Test Recipe', slug: 'test-recipe') }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing expected Recipe attributes" do
      hash_body = nil
      expect { hash_body = JSON.parse(response.body).with_indifferent_access }.not_to raise_exception
      expect(hash_body.keys).to match_array(["recipe", "equipment", "ingredients"])
      expect(hash_body).to match({
        "recipe" => {
          "id"=>recipe.id, 
          "name"=>"Test Recipe", "slug"=>"test-recipe", 
          "action_array"=>[],
          "author"=>nil, "origin"=>nil,
          "card_image_path"=>"",
          "cook_time"=>0, "prep_time"=>0, "difficulty"=>1, 
          "ingredient_score"=>0,
          "views"=>nil, "saves"=>nil
        },
        "equipment" => [],
        "ingredients" => [],
      })
    end
  end

end
