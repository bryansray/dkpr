require 'spec_helper'

describe Character do
  before(:each) do
    @character = Factory.build(:character)
  end
  
  it "should be able to have a list of tags" do
    character = Factory.create(:character, :tag_list => "member, tank")
    character.should have(2).tags
  end
  
  it "should have adjustments to their dkp" do
    character = Factory.create(:character)
    adjustment = Adjustment.create :amount => 5, :adjustee => character
    character.should have(1).adjustments
  end
  
  it "should take the characters adjustments in to account when summing dkp" do
    character = Factory.create(:character, :name => "Foo")
    character.adjustments.create :amount => 5
    character.adjustments.sum(:amount).should == 5
  end
  
  it "should be able to have negative adjustments as well" do
    character = Factory.create(:character, :name => "Foo")
    character.adjustments.create :amount => 20
    character.adjustments.create :amount => -10
    character.adjustments.sum(:amount).should == 10
  end
  
  it "should take the adjustments in to account when summing up their current_dkp" do
    character = Factory.create(:character, :name => "Foo")
    character.adjustments.create :amount => 20
    character.current_dkp.should == 20
  end
  
  it "should belong to a user of the dkp system" do
    user = Factory.build(:user)
    @character.owner = user
    @character.owner.should == user
  end
  
  it "should be invalid with a level lower than 1 and greater than 80" do
    @character.level = 0
    @character.should_not be_valid
    
    @character.level = 81
    @character.should_not be_valid
    
    @character.level = 80
    @character.should be_valid
  end
  
  it "should attend raids" do
    raid_1, raid_2 = Factory.build(:raid), Factory.build(:raid)
    character = Factory.build(:character, :raids => [raid_1, raid_2])
    character.should have(2).raids
  end
  
  it "should be a specific character class" do
    character_class = Factory.build(:character_class)
    character = Factory.build(:character, :character_class => character_class)
    character.character_class.should == character_class
  end

  # 1. Earn 5 DKP being on time
  # 2. Earn 5 DKP every hour you're *at* the raid
  # 3. Every boss kill earns 5 DKP
  # 4. Every progression kill earns an *additional* 5 DKP
  # 5. Being on time and being there 100% of raid earns 5 DKP
  it "should have an earned dkp value"
  
  it "should award the character 5 DKP for being on time to a raid" do
    character = Factory.build(:character)
    raid = Factory.build(:raid, :started_at => Time.now)
    raid_2 = Factory.build(:raid, :started_at => Time.now)
    attendee = Attendee.create :character => character, :raid => raid, :joined_at => Time.now - 15.minutes
    attendee = Attendee.create :character => character, :raid => raid_2, :joined_at => Time.now - 1.hour
    character.on_time_dkp.should == 10
  end
  
  it "should earn 5 dkp for every hour the character attended a raid" do
    character = Factory.build(:character)
    raid = Factory.build(:raid, :started_at => Time.now, :ended_at => Time.now + 3.hours)
    # raid_2 = Factory.build(:raid, :started_at => Time.now)
    attendee = Attendee.create :character => character, :raid => raid, :joined_at => Time.now - 15.minutes, :left_at => Time.now + 2.hours
    # attendee = Attendee.create :character => character, :raid => raid_2, :joined_at => Time.now - 1.hour
    character.hours_attended_dkp.should == 10
  end
  
  it "should earn 5 DKP for attending a boss kill" do
    character = Factory.build(:character)
    raid = Factory.build(:raid, :started_at => Time.now, :ended_at => Time.now + 3.hours)
    boss = Factory.build(:boss)
    attendee = Attendee.new :character => character, :raid => raid
    kill = Kill.create(:attendee => attendee, :raid => raid, :boss => boss)
    character.boss_kill_dkp.should == 5
  end
  
  it "should have an adjusted dkp value"
  
  it "should calculate attendence for being on time to a raid" do
    character = Factory.create(:character)
    raid = Factory.create(:raid, :started_at => Time.now, :ended_at => Time.now + 3.hours)
    character.attendances.create :raid => raid, :joined_at => Time.now - 5.minutes
    character.calculate_ontime_attendance.should == 5
  end
  
  xit "should have killed a lot of things" do
    character = Factory.build(:character)
    boss = Boss.create
    kill = Kill.create :character => character, :boss => boss
    character.should have(1).kills
  end
  
  xit "should have a lot of boss kills" do
    character = Factory.build(:character)
    boss = Boss.create
    kill = Kill.create :character => character, :boss => boss
    character.should have(1).killed_bosses
  end
    
  it "should return 0 if a user did not attend the raid" do
    raid = Factory.build(:raid, :started_at => Time.now, :ended_at => Time.now + 3.hours)
    character = Factory.build(:character)
    character.calculate_dkp_for(raid).should == 0
  end
  
  it "should have a current dkp value" do
    character = Factory.create(:character)
    raid = Factory.build(:raid, :started_at => Time.now, :ended_at => Time.now + 3.hours)
    character.attendances.create :raid => raid, :joined_at => Time.now - 15.minutes, :left_at => Time.now + 3.hours
    character.current_dkp.should == 25
  end

  it "should have percentage of raids attended overall" do
    raid_1 = Factory.create(:raid)
    raid_2 = Factory.create(:raid)
    attendee = Attendee.create :character => @character, :raid => raid_1
    @character.lifetime_attendance_percentage.should == 50
  end
  
  it "should have a percentage of raids attended over the last 30 days" do
    raid_1 = Factory.create(:raid, :created_at => Time.now - 28.days)
    raid_2 = Factory.create(:raid)
    attendee = Attendee.create :character => @character, :raid => raid_1
    @character.raids.should have(1).within(30.days.ago)
  end
  
  it "should have purchased many items" do
    item = Factory.build(:item)
    drop = Drop.new :item => item
    character = Factory.build(:character, :drops => [drop])
    character.should have(1).drops
  end

  it "should create a new instance given valid attributes" do
    character = Factory.build :character
  end
  
  it "should have a unique character name" do
    character_1 = Factory.create :character, :name => "Character1"
    character_2 = Factory.build :character, :name => "Character1"
    
    character_2.should_not be_valid
  end
  
  it "should be able to (but not required to) be associated with a specific user" do
    user = Factory.build :user
    character = Factory.build :character, :user => user
    character.user.should eql(user)
  end
  
  it "should have attended multiple raids" do
    character = Factory.build :character
    raid = Factory.create :raid, :characters => [character]
    
    character.should have(1).raids
    character.raids.should include(raid)
  end
  
  it "should be present on two attempts" do
    character = Factory.create :character
    raid = Factory.create :raid
    attempt = Factory.create :attempt, :characters => [character], :raid => raid
    attempt = Factory.create :attempt, :characters => [character], :raid => raid
    
    character.should have(2).attempts
  end

  it "should be have wait list reporting capabilities" do
    character = Factory.create :character
    raid = Factory.create :raid
    attempt = Factory.create :attempt, :characters => [character], :raid => raid
    attempt.participants.first.present = false
    attempt.participants.first.save
    attempt = Factory.create :attempt, :characters => [character], :raid => raid
    
    character.should have(1).wait_listed
  end
  
  it "should have a total of 10 points for being to two raids on time" do
    character = Factory.create :character
    raid = Factory.create(:raid, :started_at => Time.now)
    attendee = Factory.create(:attendee, :character => character, :raid => raid, :joined_at => Time.now - 5.minutes)

    character.lifetime_points.should == 5
  end
  
  it "should have a total of 5 points for being to one raid on time" do
    started_at = DateTime.now
    joined_late = started_at + 1.second
    character = Factory.create :character
    raid_1 = Factory.create :raid, :started_at => started_at
    raid_2 = Factory.create :raid, :started_at => started_at

    attendee = Factory.create :attendee, :character => character, :raid => raid_1, :joined_at => started_at
    attendee = Factory.create :attendee, :character => character, :raid => raid_2, :joined_at => joined_late
    
    character.lifetime_points.should == 5
  end
  
  it "should have earned 10 points for attending a raid the entire time" do
    
  end
  
  it "should have earned 10 points for being at a raid for 2 hours"
  it "should have earned 5 points for being at 1 attempt"
  it "should have earned 10 points for being at 2 attempts"
  
  it "should have a few of attendances" do
    character = Factory.create :character
    raid = Factory.create :raid, :characters => [character]

    character.should have(1).attendances
  end
end
