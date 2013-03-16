class AddOAuthColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :nickname, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :description, :string
    add_column :users, :image, :string
    add_column :users, :phone, :string
    add_column :users, :token, :string
    add_column :users, :secret, :string
  end
end
