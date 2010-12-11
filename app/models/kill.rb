class Kill < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :raid
  belongs_to :boss
  
  # Named scopes
  named_scope :during_raid, lambda { |raid| { :conditions => { :raid_id => raid.id } } }

  named_scope :present, :conditions => { :present => true }
  named_scope :wait_listed, :conditions => { :present => false }
  
end
