require 'spec_helper'

describe AttendeesController do

  describe "GET 'raids/1/attendees'" do
    let(:raid) { mock_model(Raid) }
    
    before(:each) do
      Raid.stub!(:find).and_return(raid)
      raid.stub!(:character_classes)
    end
    
    it "should be successful" do
      get 'index', :raid_id => 1
      response.should be_success
    end
    
    it "should find the specific raid that you want attendees for" do
      Raid.should_receive(:find).and_return(raid)
      get 'index', :raid_id => 1
    end
    
    it "should find the list of character classes that attended the raid" do
      raid.should_receive(:character_classes).and_return([])
      get 'index', :raid_id => 1
    end
    
    it "should assign the character classes to the associated view" do
      character_class = Factory.build(:character_class)
      character_classes = [character_class]
      raid.stub!(:character_classes).and_return(character_classes)
      get 'index', :raid_id => 1
      assigns[:character_class_sums].should == character_classes
    end
  end

  describe "GET 'show' /raids/1/attendees/1" do
    let(:raid) { mock_model(Raid) }
    let(:attendee) { mock_model(Attendee) }
    
    before(:each) do
      attendees = [attendee]
      
      Raid.stub!(:find).and_return(raid)
      raid.stub!(:attendees).and_return(attendees)
      attendees.stub!(:find).and_return(attendee)
    end
    
    it "should be successful" do
      get 'show', :raid_id => 1, :id => 1
      response.should be_success
    end
    
    it "should find the raid for this specific attendee" do  
      Raid.should_receive(:find).and_return(raid)
      raid.should_receive(:attendees).and_return([attendee])
      
      get 'show', :raid_id => 1, :id => 1
    end
    
    it "should assign the attendee to the specific view" do
      get 'show', :raid_id => 1, :id => 1
      assigns[:attendee].should == attendee
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

end
