require 'spec_helper'

describe Attendee do
  before(:each) do
    @character = Factory.build(:character)
    @raid = Factory.build(:raid, :started_at => Time.now, :ended_at => Time.now + 2.hours)
    @attendee = Attendee.new :character => @character, :raid => @raid, :joined_at => Time.now - 15.minutes, :left_at => Time.now + 2.hours
  end

  it "should be able to construct a valid factory object" do
    attendee = Factory.build :attendee
    attendee.should be_valid
  end
  
  it "should belong to a specific raid" do
    character = Factory.build :character
    raid = Factory.build :raid
    attendee = Attendee.new :character => character, :raid => raid
  end
  
  it "should have a specific character associated with it" do
    character = Factory.build :character
    raid = Factory.build :raid
    attendee = Attendee.new :character => character, :raid => raid
    attendee.character.should eql(character)
  end

  it "should have joined the raid at a specific time" do
    joined_at = DateTime.now
    attendee = Factory.build :attendee, :joined_at => joined_at
    attendee.joined_at.should eql(joined_at)
  end
  
  it "should be able to tell you whether or not you joined the raid on time" do
    joined_at = DateTime.now - 15
    started_at = DateTime.now
    raid = Factory.build :raid, :started_at => started_at
    attendee = Factory.build :attendee, :raid => raid, :joined_at => joined_at
    attendee.should be_on_time
  end
  
  it "should be able to tell you if a character did not make it to a raid on time" do
    joined_at = DateTime.now + 15
    started_at = DateTime.now
    raid = Factory.build :raid, :started_at => started_at
    attendee = Factory.build :attendee, :raid => raid, :joined_at => joined_at
    attendee.should_not be_on_time
  end
  
  it "should be able to tell you if a character left the raid early" do
    now = DateTime.now
    joined_at = now - 15.minutes
    left_at = now + 30.minutes
    started_at = now
    ended_at = now + 1.hour
    
    raid = Factory.build :raid, :started_at => started_at, :ended_at => ended_at
    attendee = Factory.build :attendee, :raid => raid, :joined_at => joined_at, :left_at => left_at
    attendee.should be_left_early
  end
  
  it "should be able to tell you whether or not the character attended the entire raid" do
    now = DateTime.now
    joined_at = now - 15.minutes
    left_at = now + 1.hour
    started_at = now
    ended_at = now + 1.hour
    
    raid = Factory.build :raid, :started_at => started_at, :ended_at => ended_at
    attendee = Factory.build :attendee, :raid => raid, :joined_at => joined_at, :left_at => left_at
    
    attendee.should be_there_the_whole_time
  end
  
  it "should not have attended the entire raid" do
    now = DateTime.now
    joined_at = now + 15.minutes
    left_at = now + 1.hour
    started_at = now
    ended_at = now + 1.hour
    
    raid = Factory.build :raid, :started_at => started_at, :ended_at => ended_at
    attendee = Factory.build :attendee, :raid => raid, :joined_at => joined_at, :left_at => left_at
    
    attendee.should_not be_there_the_whole_time
  end

  it "should have been there for a specific duration of the raid" do
    now = DateTime.now
    attendee = Factory.build :attendee, :joined_at => now, :left_at => now + 2.hours
    attendee.time_attended.should == 2.hours
  end

  it "should earn 5 points for being to a raid on time" do
    started_at = DateTime.now
    joined_at = started_at - 15.minutes
    
    raid = Factory.create :raid, :started_at => started_at
    attendee = Factory.create :attendee, :raid => raid, :joined_at => joined_at

    attendee.on_time_points.should == 5
  end
  
  it "should not earn 5 points for being late to a raid" do
    now = DateTime.now
    joined_at = now + 15.minutes
    
    raid = Factory.build :raid, :started_at => now
    attendee = Factory.build :attendee, :raid => raid, :joined_at => joined_at
    
    attendee.should_not be_on_time
    attendee.on_time_points.should == 0
  end
  
  it "should earn 5 points for attending the raid the entire time" do
    now = DateTime.now
    ended = now + 1.hour
    joined_at = now - 15.minutes
    left_at = now + 1.hour
    
    raid = Factory.create :raid, :started_at => now, :ended_at => ended
    attendee = Factory.create :attendee, :raid => raid, :joined_at => joined_at, :left_at => left_at
    
    attendee.should be_there_the_whole_time
    attendee.full_time_points.should == 5
  end
  
  it "should NOT earn 5 points for attending the raid the entire time" do
    now = DateTime.now
    ended = now + 1.hour
    joined_at = now + 15.minutes
    left_at = now + 30.minutes
    
    raid = Factory.build :raid, :started_at => now, :ended_at => ended
    attendee = Factory.build :attendee, :raid => raid, :joined_at => joined_at, :left_at => left_at
    
    attendee.should_not be_there_the_whole_time
    attendee.full_time_points.should == 0
  end
  
  it "should earn the default account points for being on time to a raid" do
    started_at = DateTime.now
    joined_at = started_at - 15.minutes
    
    account = Factory.build :account, :default_on_time_points => 10
    raid = Factory.create :raid, :started_at => started_at, :account => account
    attendee = Factory.create :attendee, :raid => raid, :joined_at => joined_at

    attendee.on_time_points.should == 10
  end
  
  it "should earn the default account points for being to a raid the entire duration" do  
    now = DateTime.now
    ended = now + 1.hour
    joined_at = now - 15.minutes
    left_at = now + 1.hour

    account = Factory.build :account, :default_full_time_points => 10
    raid = Factory.create :raid, :started_at => now, :ended_at => ended, :account => account
    attendee = Factory.create :attendee, :raid => raid, :joined_at => joined_at, :left_at => left_at
    
    attendee.should be_there_the_whole_time
    attendee.full_time_points.should == 10
  end
  
  it "should have attended a specific raid" do
    @attendee.raid.should == @raid
  end
  
  it "should delegate some methods to the character class" do
    @attendee.name.should == @character.name
    @attendee.level.should == @character.level
    @attendee.character_class.should == @character.character_class
  end
  
  it "should have three attended bosses"

  it "should have two boss kills" do
    attendee = Factory.build(:attendee)
    kill = Kill.create :attendee => attendee
    kill = Kill.create :attendee => attendee
    attendee.should have(2).kills
  end
  
  xit "should have missed out on two boss kills" do
    attendee_1, attendee_2 = Attendee.create, Attendee.create
    raid = Factory.build(:raid)
    boss_1, boss_2, boss_3 = Factory.create(:boss), Factory.create(:boss), Factory.create(:boss)
    kill = Kill.create :raid => raid, :attendee => attendee_1, :boss => boss_1
    kill = Kill.create :raid => raid, :attendee => attendee_2, :boss => boss_2
    kill = Kill.create :raid => raid, :attendee => attendee_2, :boss => boss_2
    p "attendee_1 id = #{attendee_1.id}"
    p "attendee_2 id = #{attendee_2.id}"
    attendee_1.should have(2).inverted_kills
  end
  
  it "should be able to calculate the number of hours the raider attended" do
    @attendee.hours_attended.should == 2
  end
  
  it "should have a dkp value for the number of hours attending the raid" do
    @attendee.calculate_hours_attended_dkp.should == 10
  end

  it "should have stayed the full raid" do
    @attendee.left_at = @raid.ended_at
    @attendee.should have_attended_full_raid
  end
  
  it "should have been late to the raid" do
    @attendee.joined_at = Time.now + 1.hour
    @attendee.should be_late
  end

  it "should have a spent sum of dkp value" do
    attendee = Factory.build(:attendee)
    item_1, item_2 = Factory.build(:item), Factory.build(:item)
    drop_1 = Drop.create :item => item_1, :attendee => attendee, :price => 20
    drop_2 = Drop.create :item => item_2, :attendee => attendee, :price => 10

    attendee.spent.should == 30
  end
  
  it "should have a calculated dkp value for whether or not he was late" do
    @attendee.calculate_on_time_dkp.should == 5
  end
  
  it "should not be late to the raid if the joined time is less than or equal to the start time" do
    @attendee.joined_at = Time.now - 10.minutes
    @attendee.should_not be_late
  end
  
  it "should be able to calculate all the of dkp" do
    @attendee.earned.should == 20
  end
  
  it "should be able to list all the characters who did *not* attend the raid" do
    raid = Factory.create(:raid)
    character_1 = Factory.create(:character, :name => "Virtual")
    character_2 = Factory.create(:character, :name => "Foo")
    attendee = Attendee.create :raid => raid, :character => character_1
    raid.characters.inverse.should == [character_2]
  end

  it "should automatically add the attendee to boss kills after saving" do
    pending "Refactor this shitty test ..."
    boss = Factory.build(:boss)
    character = Factory.create(:character)
    raid = Factory.create(:raid)
    kill = Kill.create :raid => raid, :boss => boss
    attendee = Attendee.create :raid => raid, :character => character
    
    attendee.should have(1).kills
  end
  
  it "should return false if the user was wait listed for any boss kills" do
    attendee = Factory.build(:attendee)
    kill = Kill.create :attendee => attendee, :present => false
    attendee.should_not be_present_for_all_kills
  end
  
  it "should be able to set all the kills for this attendee to true or false" do
      attendee = Factory.build(:attendee)
      kill = Kill.create :attendee => attendee, :present => false
      attendee.toggle_present!
      attendee.should be_present_for_all_kills
    end
end
