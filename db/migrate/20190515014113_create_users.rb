class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      # primary_key :
      t.string :email, :unique => true, :length => 126, :null => false
      t.string :name, :unique => true, :length => 32, :null => false
      t.string :password, :length => 32, :null => false
    end
  end

  def down
  	drop_table :users
  end
end
