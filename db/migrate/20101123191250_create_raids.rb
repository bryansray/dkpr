class CreateRaids < ActiveRecord::Migration
  def self.up
    create_table :raids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :raids
  end
end
