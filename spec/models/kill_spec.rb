require 'spec_helper'

describe Kill do
  before(:each) do
  end

  it "should have been killed by someone who attended a raid" do
    attendee = Factory.build(:attendee)
    kill = Kill.new :attendee => attendee
    kill.attendee.should == attendee
  end

  xit "should have been killed during a raid" do
    raid = Factory.build(:raid)
    kill = Kill.new :raid => raid
    kill.raid.should == raid
  end
  
  it "should have killed a specific boss" do
    boss = Factory.build(:boss)
    kill = Kill.new :boss => boss
    kill.boss.should == boss
  end
  
  it "should have a list of attendees who were present during the kill" do
    boss = Boss.new :name => "Boss"
    kill = Kill.create :present => true, :boss => boss
    kill = Kill.create :present => false, :boss => boss
    boss.kills.present.size.should == 1
  end
  
  it "should have a list of wait listed people during the boss kill" do
    boss = Boss.new :name => "Boss"
    kill = Kill.create :present => true, :boss => boss
    kill = Kill.create :present => false, :boss => boss
    boss.kills.wait_listed.size.should == 1
  end
  
  it "should return a list of kills during a specific raid" do
    boss = Boss.new :name => "Boss"
    raid = Factory.create(:raid)
    kill = Kill.create :raid => raid, :boss => boss
    boss.kills.during_raid(raid).size.should == 1
  end
end
