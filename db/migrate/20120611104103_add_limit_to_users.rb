class AddLimitToUsers < ActiveRecord::Migration
  def change
    add_column :users, :limit, :integer , :default => 10
  end
end
