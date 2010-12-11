require 'spec_helper'

describe Participant do
  before(:each) do
  end

  it "should create a new instance using the factory" do
    participant = Factory.build :participant
    participant.should be_valid
  end
  
  it "should have participated in a specific attempt" do
    attempt = Factory.build :attempt
    participant = Factory.build :participant, :attempt => attempt
    participant.attempt.should eql(attempt)
  end
  
  it "should be able to tell you the character that participated" do
    character = Factory.build :character
    participant = Factory.build :participant, :character => character
    participant.character.should eql(character)
  end
  
  it "should be able to tell you whether or not the character was actually present on the attempt" do
    participant = Factory.build :participant, :present => false
    participant.should_not be_present
  end

end
