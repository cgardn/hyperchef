class JoinUserprofilesRecipe < ApplicationRecord
  belongs_to :user_profile
  belongs_to :recipe
end
