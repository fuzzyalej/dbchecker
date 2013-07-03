class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :uid

      t.timestamps
    end
  end
end
