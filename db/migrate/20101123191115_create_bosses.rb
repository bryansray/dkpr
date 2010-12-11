class CreateBosses < ActiveRecord::Migration
  def self.up
    create_table :bosses do |t|
      t.string :name
      t.integer :value, :default => 5

      t.timestamps
    end
  end

  def self.down
    drop_table :bosses
  end
end
