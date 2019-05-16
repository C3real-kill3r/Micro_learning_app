class CreateCategories < ActiveRecord::Migration[5.2]
  def up
    create_table :categories do |t|
     t.string :name
    end
  end
  def down
  	drop_table :users
  end
end