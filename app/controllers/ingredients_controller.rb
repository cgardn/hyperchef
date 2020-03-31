class IngredientsController < ApplicationController
  before_action :lookup_ingredient, except: [:index, :new, :create]
  before_action :admin_user

  def index
    @ingredients = Ingredient.all.sort_by{ |obj| obj.name }
  end

  def new
    @ingredient = Ingredient.new
    @tags = @ingredient.all_tags
    @ingredient.units = @ingredient.empty_units
  end

  def create
    @ingredient = Ingredient.new

    # Setting params manually, since tags are on a join table
    #   and one-step mass-assignment doesn't work
    @ingredient.name = ingredient_params[:name]
    @ingredient.caloriespergram = ingredient_params[:caloriespergram]

    # Setting tag list
    ingredient_params[:iTags].each do |it|
      unless it[:selected] == "0"
        @ingredient.ingredient_tags << IngredientTag.find_by(name: it[:selected])
      end
    end

    # Setting new units hash (new as of 3-27-2020)
    @ingredient.units = { 
      'imperial_show' => [ ingredient_params[:imperial_show_num].to_f,
                           ingredient_params[:imperial_show_unit] ],
      'imperial_list' => [ ingredient_params[:imperial_list_num].to_f,
                           ingredient_params[:imperial_list_unit] ],
      'metric_show' => [ ingredient_params[:metric_show_num].to_f,
                         ingredient_params[:metric_show_unit] ],
      'metric_list' => [ ingredient_params[:metric_list_num].to_f,
                         ingredient_params[:metric_list_unit] ] }

    if @ingredient.save!
      redirect_to admin_path
    else
      render :new
    end
  end

  def edit
    @tags = @ingredient.all_tags
  end

  def update
    @ingredient.name = ingredient_params[:name]
    @ingredient.caloriespergram = ingredient_params[:caloriespergram]

    # Setting new units hash (new as of 3-27-2020)
    @ingredient.units = { 
      'imperial_show' => [ ingredient_params[:imperial_show_num].to_f,
                           ingredient_params[:imperial_show_unit] ],
      'imperial_list' => [ ingredient_params[:imperial_list_num].to_f,
                           ingredient_params[:imperial_list_unit] ],
      'metric_show' => [ ingredient_params[:metric_show_num].to_f,
                         ingredient_params[:metric_show_unit] ],
      'metric_list' => [ ingredient_params[:metric_list_num].to_f,
                         ingredient_params[:metric_list_unit] ] }

    # Setting tag list
    @ingredient.ingredient_tags.delete_all

    ingredient_params[:iTags].each do |it|
      unless it[:selected] == "0"
        @ingredient.ingredient_tags << IngredientTag.find_by(name: it[:selected])
      end
    end
    
    if @ingredient.save!
      redirect_to admin_path
    else
      render :edit
    end
  end

  def destroy
    @ingredient.delete
    redirect_to admin_path
  end

  private

    def admin_user
      unless user_signed_in? and current_user.admin == true
        redirect_to root_url
      end
    end

    def lookup_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    def ingredient_params
      params.require(:ingredient).permit(:name,
                                         :caloriespergram,
                                         :imperial_show_num,
                                         :imperial_show_unit,
                                         :imperial_list_num,
                                         :imperial_list_unit,
                                         :metric_show_num,
                                         :metric_show_unit,
                                         :metric_list_num,
                                         :metric_list_unit,
                                         iTags: [:selected])
    end
end
