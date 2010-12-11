class Drop < ActiveRecord::Base
  # Associations
  belongs_to :attendee
  belongs_to :boss
  belongs_to :raid
  belongs_to :item
  
  # validates_presence_of :attendee, :raid, :item
  
end
