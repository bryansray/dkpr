class CreateDkps < ActiveRecord::Migration
  def self.up
    create_table :dkps do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :dkps
  end
end
