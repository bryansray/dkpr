require 'spec_helper'

describe Raid do
  before(:each) do
    @raid = Factory.create(:raid)
  end
  
  it "should not be valid without a raid name" do
    raid = Factory.build(:raid, :name => nil)
    raid.should_not be_valid
  end
  
  it "should have multiple characters attending the raid" do
    attendee_1, attendee_2 = Attendee.new, Attendee.new
    raid = Factory.build(:raid, :attendees => [attendee_1, attendee_2])
    raid.should have(2).attendees
  end
  
  it "should have killed bosses" do
    boss = Boss.new
    raid = Factory.create(:raid)
    Factory.create(:attempt, :boss => boss, :raid => raid, :successful => true)
    raid.should have(1).kills
  end
  
  xit "should have multiple notes" do
    note = Factory.build(:note)
    raid = Factory.build(:raid, :notes => [note, note])
    raid.should have(2).notes
  end
  
  it "should have multiple items dropped" do
    drop_1, drop_2 = Factory.build(:drop), Factory.build(:drop)
    @raid.drops = [drop_1, drop_2]
    @raid.should have(2).drops
  end

  it "should be able to calculate a dkp value for the number of bosses killed" do
    boss_1, boss_2 = Factory.create(:boss), Factory.create(:boss)

    raid = Factory.create(:raid)    
    attempt = Factory.create(:attempt, :boss => boss_1, :raid => raid, :successful => true)
    attempt = Factory.create(:attempt, :boss => boss_2, :raid => raid, :successful => true)
        
    raid.earnable.should == 10
  end
  
  it "should have a max dkp value that could be earned by an attendee"
  
  it "should be able to sum up all the dkp given during the raid" do
    character = Factory.build(:character)
    raid = Factory.build(:raid, :started_at => Time.now, :ended_at => Time.now + 2.hours)
    attendee = Attendee.create :character => character, :raid => raid, :joined_at => Time.now - 15.minutes, :left_at => Time.now + 1.hour
    raid.earned_dkp.should == 10
  end
  
  it "should be able to sum up all the dkp spent during the raid" do
    attendee = Factory.build(:attendee)
    raid = Factory.build(:raid, :started_at => Time.now, :ended_at => Time.now + 2.hours)
    item = Factory.build(:item)
    drop = Factory.create(:drop, :item => item, :attendee => attendee, :raid => raid, :price => 20)
    raid.spent_dkp.should == 20
  end

  it "should create a new valid factory given valid attributes" do
    raid = Factory.build :raid
    raid.should be_valid
  end
  
  it "should not be valid if a name is not specified" do
    raid = Raid.new
    raid.should_not be_valid
    
    raid.name = "New Raid"
    raid.should be_valid
  end
  
  it "should have multiple attempts on a boss" do
    attempt = Factory.build :attempt
    raid = Factory.build :raid, :attempts => [attempt]
    raid.should have(1).attempts
    raid.should have(0).kills
  end
  
  it "should be able to have multiple boss kills associated with it" do
    raid = Factory.create :raid
    attempt = Factory.create :attempt, :raid => raid, :successful => true
    raid.attempts = [attempt]

    raid.should have(1).attempts
    raid.should have(1).kills
  end
  
  it "should have one boss associated with it" do
    boss = Factory.build :boss
    raid = Factory.create :raid, :bosses => [boss]

    raid.should have(1).bosses
  end
  
  it "should be able to have multiple bosses associated with it" do
    boss_1 = Factory.create :boss, :name => "Boss 1"
    boss_2 = Factory.create :boss, :name => "Boss 2"
    raid_1 = Factory.create :raid, :bosses => [boss_1, boss_2]
        
    raid_1.should have(2).bosses
  end
  
  it "should have been able to kill a boss" do
    boss = Factory.create :boss
    raid = Factory.create :raid

    attempt_1 = raid.attempts.create :boss => boss, :successful => false
    attempt_2 = raid.attempts.create :boss => boss, :successful => true

    raid.should have(1).kills
    raid.should have(2).attempts
  end

  it "should have characters who attended the raid" do
    character = Factory.build :character
    raid = Factory.build :raid, :characters => [character]

    raid.should have(1).characters
    raid.characters.should include(character)
  end
  
  it "should be able to tell whether or not a character attended a raid" do
    character = Factory.build :character
    raid = Factory.create :raid, :characters => [character]
    
    raid.should be_attended_by(character)
  end
  
  it "should be able to add an existing character to a raid" do
    character = Factory.create :character
    raid = Factory.create :raid
    attendee = raid.add_attendee! character
    raid.attendees.should include(attendee)
  end

  it "should be able to tell you which members were on the wait list during the entire raid (does this make sense?)" do
    raid = Factory.create :raid
    fighter = Factory.create :character
    waiter = Factory.create :character
    reserve = nil
    
    # The raid has to include attendees for them to be valid "participants" on an attempt
    raid.add_attendee! fighter
    raid.add_attendee! waiter
    
    2.times do
      attempt = Factory.create :attempt, :raid => raid

      attempt.add_participant(fighter)
      attempt.add_waiter(waiter)
      attempt.save
    end

    # RAILS_DEFAULT_LOGGER.debug("*** EXECUTING SQL ...")
    raid.should have(2).reserves
  end

  it "should belong to a specific account" do
    account = Factory.build :account
    raid = Factory.build :raid, :account => account
    raid.account.should == account
  end

  it "should be able to tell you how many character classes attended the raid", :focus => true do
    paladin = Factory.create(:character_class)
    mage = Factory.create(:character_class)
    character_1 = Factory.create(:character, :character_class => paladin)
    character_2 = Factory.create(:character, :character_class => paladin)
    character_3 = Factory.create(:character, :character_class => mage)
    
    @raid.add_attendee!(character_1)
    @raid.add_attendee!(character_2)
    @raid.add_attendee!(character_3)
    
    pp @raid.character_classes
    
    @raid.should have(2).character_classes
  end
end
