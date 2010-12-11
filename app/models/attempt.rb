class Attempt < ActiveRecord::Base
  belongs_to :raid
  belongs_to :boss
  
  has_many :participants
  has_many :characters, :through => :participants
  has_many :reserves, :class_name => "Participant", :conditions => { :present => false }
  
  validates_each :participants do |record, attr, value|
    result = value.all? do |p| 
      record.errors.add attr.to_s.singularize, 'does not exist in the raid attendee list.' unless record.raid.characters.include?(p.character)
      # not (record.errors.add attr.to_s.singularize, 'does not exist in the raid attendee list.' unless record.raid.characters.include?(p.character))
    end
  end
  
  def add_participants(characters)
    characters.each { |character| add_participant(character) }
  end
  
  def add_waiters(chars)
    chars.each { |character| add_waiter(character) }
  end
  
  def add_participant(character)
    participants.build :character => character, :present => true
  end
  
  def add_waiter(character)
    participants.build :character => character, :present => false    
  end
  
end
