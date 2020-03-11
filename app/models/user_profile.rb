class UserProfile < ApplicationRecord
  belongs_to :user
  has_many :join_userprofiles_recipes
  has_many :favorites, through: :join_userprofiles_recipes, source: :recipe

end
