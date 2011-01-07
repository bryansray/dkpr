require 'spec_helper'

describe DropsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index', :raid_id => 1
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :raid_id => 1, :id => 1
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      get 'update', :raid_id => 1, :id => 1
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :raid_id => 1, :id => 1
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :raid_id => 1
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create', :raid_id => 1
      response.should be_success
    end
  end

end
