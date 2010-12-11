class CreateCharacterClasses < ActiveRecord::Migration
  def self.up
    create_table :character_classes do |t|
      t.string :name, :color

      t.timestamps
    end
    
    CharacterClass.create :name => "Death Knight", :color => "#C41F3B"
    CharacterClass.create :name => "Druid", :color => "#FF7D0A"
    CharacterClass.create :name => "Hunter", :color => "#ABD473"
    CharacterClass.create :name => "Mage", :color => "#69CCF0"
    CharacterClass.create :name => "Paladin", :color => "#F58CBA"
    CharacterClass.create :name => "Priest", :color => "#FFFFFF"
    CharacterClass.create :name => "Rogue", :color => "#FFF569"
    CharacterClass.create :name => "Shaman", :color => "#2459FF"
    CharacterClass.create :name => "Warlock", :color => "#9482C9"
    CharacterClass.create :name => "Warrior", :color => "#C79C6E"

  end

  def self.down
    drop_table :character_classes
  end
end
