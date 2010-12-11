class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.integer :character_class_id
      t.string :name
      t.integer :level
      t.boolean :active, :default => true
      
      t.integer :account_id, :null => false
      t.integer :user_id, :null => true
      
      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
