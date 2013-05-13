class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string :name
      t.text :summary
      t.string :url
      t.datetime :published_at
      t.string :guid
      t.boolean :favourite,             :default => false
      t.integer :channel_id

      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
