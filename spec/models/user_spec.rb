require 'spec_helper'

describe User do
  before(:each) do
    @user = Factory.build :user
  end

  it "should create a new instance given valid attributes" do
    @user.should be_valid
  end
  
  it "should not be valid if the user does not have a unique email address" do
    user_1 = Factory.create :user, :email => "email@example.com"
    user_2 = Factory.build :user, :email => "email@example.com"
    
    user_1.should be_valid

    user_2.should_not be_valid
    user_2.should have_exactly(1).errors
  end
  
  it "should not be valid if the users login has already been taken" do
    user_1 = Factory.create :user, :login => "joe.user"
    user_2 = Factory.build :user, :login => "joe.user"
    
    user_1.should be_valid

    user_2.should_not be_valid
    user_2.should have_exactly(1).errors
  end
  
  it "should belong to a specific account" do
    account = Factory.build :account
    user_1 = Factory.create :user, :account => account
    user_1.account.should eql(account)
  end
  
end
