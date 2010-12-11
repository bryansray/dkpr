class CreateAdjustments < ActiveRecord::Migration
  def self.up
    create_table :adjustments do |t|
      t.integer :adjustee_id
      t.string :adjustee_type
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :adjustments
  end
end
