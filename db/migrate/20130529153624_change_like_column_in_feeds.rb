class ChangeLikeColumnInFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :likes, :integer, default: 0
  end
end
