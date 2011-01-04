require 'spec_helper'

describe CharactersController do
  let(:character) { mock_model(Character).as_null_object }
    
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "GET 'show/1'" do
    it "should be successful" do
      get 'show', :id => 1
      response.should be_success
    end
    
    it "should render the 'show' template" do
      get 'show', :id => 1
      response.should render_template('show')
    end
    
    it "should assign the character to be associated with the view" do
      mock_character = mock_model(Character)
      Character.stub!(:where).and_return(mock_character)
      mock_character.stub!(:first).and_return(mock_character)
      mock_character.stub!(:attendances).and_return([])
      get 'show', :id => 1
      assigns[:character].should == mock_character
    end
    
    it "should assign the attendances for this character to the associated view" do
      attendance = mock_model(Attendee)
      attendances = [attendance]

      Character.stub!(:where).and_return(character)

      character.should_receive(:first).and_return(character)
      character.should_receive(:attendances).and_return(attendances)
      
      get 'show', :id => 1
      
      assigns[:attendances].should == attendances
    end
  end
  
  describe "GET '/characaters/new" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should render the new template for the view" do
      get 'new'
      response.should render_template('new')
    end
    
    it "should render a newly instantiated character to the view" do
      Character.should_receive(:new).and_return(character)
      get 'new'
      assigns[:character].should equal(character)
    end
  end

end
