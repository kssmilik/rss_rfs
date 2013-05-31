class CreateFavouriteFeeds < ActiveRecord::Migration
  def change
    create_table :favourite_feeds do |t|
      t.references :user
      t.references :feed

      t.timestamps
    end
  end
end
