class CreateUserCategories < ActiveRecord::Migration[5.2]
  def up
    create_table :user_categories do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
  def down
  	drop_table :user_categories
  end
end
