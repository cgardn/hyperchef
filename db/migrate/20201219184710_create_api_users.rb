class CreateApiUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :api_users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
