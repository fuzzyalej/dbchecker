class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :provider_id

      t.string :url
      t.string :bio
      t.integer :number_of_friends
      t.integer :number_of_points

      t.timestamps
    end
  end
end
