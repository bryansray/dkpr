class CreateKills < ActiveRecord::Migration
  def self.up
    create_table :kills do |t|
      t.integer :raid_id, :boss_id, :attendee_id
      t.boolean :present, :default => true
      t.datetime :killed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :kills
  end
end
