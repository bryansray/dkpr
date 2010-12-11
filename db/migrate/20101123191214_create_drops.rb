class CreateDrops < ActiveRecord::Migration
  def self.up
    create_table :drops do |t|
      t.integer :item_id, :attendee_id, :raid_id, :boss_id
      t.integer :price
      t.datetime :looted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :drops
  end
end
