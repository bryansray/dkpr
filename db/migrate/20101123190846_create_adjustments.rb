class CreateAdjustments < ActiveRecord::Migration
  def self.up
    create_table :adjustments do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :adjustments
  end
end
