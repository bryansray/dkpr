# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

character_classes = []    
character_classes << CharacterClass.create(:name => "Death Knight", :color => "#C41F3B")
character_classes << CharacterClass.create(:name => "Druid", :color => "#FF7D0A")
character_classes << CharacterClass.create(:name => "Hunter", :color => "#ABD473")
character_classes << CharacterClass.create(:name => "Mage", :color => "#69CCF0")
character_classes << CharacterClass.create(:name => "Paladin", :color => "#F58CBA")
character_classes << CharacterClass.create(:name => "Priest", :color => "#FFFFFF")
character_classes << CharacterClass.create(:name => "Rogue", :color => "#FFF569")
character_classes << CharacterClass.create(:name => "Shaman", :color => "#2459FF")
character_classes << CharacterClass.create(:name => "Warlock", :color => "#9482C9")
character_classes << CharacterClass.create(:name => "Warrior", :color => "#C79C6E")

bosses = []
bosses << Factory.create(:boss)
bosses << Factory.create(:boss)
bosses << Factory.create(:boss)
bosses << Factory.create(:boss)
bosses << Factory.create(:boss)

raids = []
raids << Factory.create(:raid)

character = nil
1.upto(5) do |i|
  user = Factory.create(:user)
  boss_id = i
  boss_id -= 5 if i < 5
  boss = bosses[boss_id]
  
  character = Factory.create(:character, :owner => user, :character_class => character_classes[Random.new.rand(character_classes.count)])
  attendance = Factory.create(:attendee, :character => character, :raid => raids.first, :joined_at => raids.first.started_at)
  drop = Factory.create(:drop, :attendee => attendance, :boss => boss, :raid => raids.first, :item => Factory.create(:item), :price =>  Random.new.rand(20..150), :looted_at => Time.now)
  kill = Factory.create(:kill, :boss => boss, :attendee => attendance, :raid => raids.first)
  attempt = Factory.create(:attempt, :raid => raids.first, :boss => boss, :characters => [character], :successful => Random.new.rand(0..1), :started_at => raids.first.started_at + 10.minutes, :ended_at => raids.first.started_at + 15.minutes)
end

