class UserProfilesController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :udpate, :destroy]
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy,
                                          :add_favorite_recipe,
                                          :remove_favorite_recipe]

  # don't need this
  def index
  end

  # GET /user_profiles/1
  # GET /user_profiles/1.json
  #   access controlled to current user
  def show
  end

  # GET /user_profiles/new
  #   only happens during new user signup, maybe managed by user controller
  def new
    @user_profile = UserProfile.new
  end

  # GET /user_profiles/1/edit
  #   only current user
  def edit
  end

  # POST /user_profiles
  # POST /user_profiles.json
  #   same as new
  def create
    @user_profile = UserProfile.new(user_profile_params)

    respond_to do |format|
      if @user_profile.save
        format.html { redirect_to @user_profile, notice: 'User profile was successfully created.' }
        format.json { render :show, status: :created, location: @user_profile }
      else
        format.html { render :new }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_profiles/1
  # PATCH/PUT /user_profiles/1.json
  #   only current user
  def update
    respond_to do |format|
      if @user_profile.update(user_profile_params)
        format.html { redirect_to @user_profile, notice: 'User profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_profile }
      else
        format.html { render :edit }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_profiles/1
  # DELETE /user_profiles/1.json
  #   only current user
  def destroy
    @user_profile.destroy
    respond_to do |format|
      format.html { redirect_to user_profiles_url, notice: 'User profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_favorite_recipe
    newRec = Recipe.find(favorite_params)
    unless @user_profile.favorites.include?(newRec)
      @user_profile.favorites << newRec
    end
    puts "!!--!!"
    puts params
    redirect_back(fallback_location: search_path)
  end

  def remove_favorite_recipe
    dumpRec = Recipe.find(favorite_params)
    @user_profile.favorites.delete(dumpRec)
    puts "**!!**"
    puts params
    redirect_back(fallback_location: search_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    
    def correct_user
      # only correct user can see profile while logged in
      unless user_signed_in? and UserProfile.find(params[:id]).user == current_user
        redirect_to("/search")
      end
    end

    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
      @favorites = @user_profile.favorites
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    
    def favorite_params
      params.fetch(:addFavID)
    end

    def user_profile_params
      params.fetch(:user_profile, {})
    end
end
