class CreateDrops < ActiveRecord::Migration
  def self.up
    create_table :drops do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :drops
  end
end
