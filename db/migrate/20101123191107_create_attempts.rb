class CreateAttempts < ActiveRecord::Migration
  def self.up
    create_table :attempts do |t|
      t.integer :raid_id, :boss_id
      
      t.boolean :successful
      t.datetime :started_at, :ended_at

      t.timestamps
    end
  end

  def self.down
    drop_table :attempts
  end
end
