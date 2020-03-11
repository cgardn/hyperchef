class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.references :user

      t.timestamps
    end

    create_table :join_userprofiles_recipes do |t|
      t.references :user_profile
      t.references :recipe

      t.timestamps
    end
  end
end
