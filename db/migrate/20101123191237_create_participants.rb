class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.integer :attempt_id, :character_id
      t.boolean :present, :default => true
      
      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
