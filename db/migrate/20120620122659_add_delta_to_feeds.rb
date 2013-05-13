class AddDeltaToFeeds < ActiveRecord::Migration
  def change
  	add_column :feeds, :delta, :boolean, :default => true,
    :null => false
  end
end
