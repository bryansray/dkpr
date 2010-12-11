class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.integer :raid_id, :character_id
      t.float :on_time_points, :full_time_points, :default => 0, :null => false
      t.datetime :joined_at, :left_at

      t.timestamps
    end
  end

  def self.down
    drop_table :attendees
  end
end
