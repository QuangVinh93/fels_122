class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin
      t.string :password

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_column :users, :password_digest, :string
    add_column :users, :remember_digest, :string
  end
end
