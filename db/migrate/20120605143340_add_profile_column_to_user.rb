class AddProfileColumnToUser < ActiveRecord::Migration
  def change
      add_column :users, :profile, :string,       :null => false, :default => "basic"
  end
end
