require 'spec_helper'

describe Attempt do
  before(:each) do
  end

  it "should create a new instance via the factory" do
    attempt = Factory.build :attempt
    attempt.should be_valid
  end
  
  it "should have multiple participants who participated" do
    participant = Factory.build :participant
    attempt = Factory.build :attempt, :participants => [participant]
    attempt.should have(1).participants
  end
  
  it "should have multiple characters who were present" do
    character = Factory.build :character
    attempt = Factory.build :attempt, :characters => [character]
    attempt.should have(1).characters
    attempt.characters.should include(character)
  end
  
  it "should have a character who was not present during the attempt" do
    character_1 = Factory.create :character
    character_2 = Factory.create :character
    raid = Factory.create :raid, :characters => [character_1, character_2]
    attempt = Factory.create :attempt, :raid => raid

    participant_1 = Factory.create :participant, :character => character_1, :attempt => attempt, :present => true
    participant_2 = Factory.create :participant, :character => character_2, :attempt => attempt, :present => false

    attempt.participants.reload

    attempt.should have(2).participants
    attempt.should have(1).reserves
  end
  
  it "should have a nicer method to handle the addition of characters as participants and waiters" do
    character_1 = Factory.create :character
    character_2 = Factory.create :character
    raid = Factory.create :raid, :characters => [character_1, character_2]
    attempt = Factory.create :attempt, :raid => raid
    
    attempt.add_participant character_1
    attempt.add_waiter character_2

    attempt.save
    
    attempt.should have(2).participants
    attempt.should have(1).reserves
  end
  
  it "should have a way to add the addition of multiple characters as participants" do
    character_1 = Factory.create :character
    character_2 = Factory.create :character
    raid = Factory.create :raid, :characters => [character_1, character_2]
    attempt = Factory.create :attempt, :raid => raid
    
    attempt.add_participants [character_1, character_2]
    attempt.save
    
    attempt.should have(2).participants
    attempt.should have(0).reserves
  end
  
  it "should have a way to add the addition of multiple characters as waiters" do
    character_1 = Factory.create :character
    character_2 = Factory.create :character
    raid = Factory.create :raid, :characters => [character_1, character_2]
    attempt = Factory.create :attempt, :raid => raid
    
    attempt.add_waiters [character_1, character_2]
    attempt.save
    
    attempt.should have(2).participants
    attempt.should have(2).reserves
  end
  
  it "should not allow the addition of a character to an attempt that is not in the raid participant list" do
    character_1 = Factory.create :character
    character_2 = Factory.create :character
    character_3 = Factory.create :character
    raid = Factory.create :raid, :characters => [character_1]
    attempt = Factory.create :attempt, :raid => raid, :characters => [character_2, character_3]
    
    attempt.should_not be_valid
  end

end
