class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.text :summary
      t.string :url
      t.boolean :favourite

      t.timestamps
    end
  end
end
