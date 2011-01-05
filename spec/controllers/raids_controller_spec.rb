require 'spec_helper'

describe RaidsController do
  describe "GET 'index'" do
    let(:raid) { mock_model(Raid) }
    
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "should render a list of raids to the view" do
      raids = [raid]
      Raid.should_receive(:all).and_return(raids)
      get 'index'
      assigns[:raids].should == raids
    end
  end
  
  describe "GET 'show/1" do
    let(:raid) { mock_model(Raid) }
    
    before(:each) do
      attendee = mock_model(Attendee)

      Raid.stub!(:find).and_return(raid)
      raid.stub!(:attendees)
      raid.stub!(:characters_that_did_not_attend)
    end
    
    it "should be successful" do
      get 'show', :id => 1
      response.should be_success
    end
    
    it "should find the specified raid" do
      Raid.should_receive(:find).and_return(raid)
      get 'show', :id => 1
      assigns[:raid].should equal(raid)
    end
    
    it "should assign all the attendees to the associated view" do
      attendee = mock_model(Attendee)
      attendees = [attendee]
      raid.should_receive(:attendees).and_return(attendees)
      get 'show', :id => 1
      assigns[:attendees].should == attendees
    end
    
    it "should find all of the characters who did not attend the raid", :focus => true do
      raid.should_receive(:characters_that_did_not_attend).and_return([])
      get 'show', :id => 1
    end
    
    it "should assign all the characters who did not attend the raid to the associated view" do
      
    end
  end
end
