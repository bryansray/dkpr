class CreateRaids < ActiveRecord::Migration
  def self.up
    create_table :raids do |t|
      t.string :name, :zone
      t.integer :account_id
      t.text :xml, :note
      t.datetime :started_at, :ended_at

      t.timestamps
    end
  end

  def self.down
    drop_table :raids
  end
end
