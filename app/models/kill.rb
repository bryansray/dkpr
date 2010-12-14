class Kill < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :raid
  belongs_to :boss
  
  # Scopes
  scope(:during_raid, lambda { |raid| where(:raid_id => raid.id) })
  scope :present, where(:present => true)
  scope :wait_listed, where(:present => false)
end