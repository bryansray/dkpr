class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.float :default_on_time_points, :default_full_time_points, :default => 5, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
