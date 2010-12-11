require 'spec_helper'

describe Drop do
  before(:each) do
    @drop = Factory.build(:drop)
  end

  xit "should be valid with a price less than 20" do
    @drop.price = 15
    @drop.should be_valid
  end
  
  it "should have been purchased by someone who attended the raid" do
    a = Factory.build(:attendee)
    drop = Factory.build(:drop, :attendee => a)
    drop.attendee.should == a
  end
  
  it "should have been purchased during a raid" do
    r = Factory.build(:raid)
    drop = Factory.build(:drop, :raid => r)
    drop.raid.should == r
  end
  
  it "should have purchased a specific item" do
    i = Factory.build(:item)
    drop = Factory.build(:drop, :item => i)
    drop.item.should == i
  end

end
