class AddLimitToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :limit, :integer, :default => 10
  end
end
