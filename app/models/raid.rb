class Raid < ActiveRecord::Base
  # Validations
  validates_presence_of :name

  # Assocations
  belongs_to :account
  # has_many :attendees, :include => :character, :order => "characters.name", :dependent => :destroy
  has_many :attendees, :dependent => :destroy
  has_many :characters, :through => :attendees
  # , :order => "characters.name" do
  #     def inverse
  #       characters = Character.all
  #       characters.reject! { |c| self.include?(c) }
  #     end
  #   end

  has_many :character_classes, :class_name => 'CharacterClass', :finder_sql => "select character_class_id, cc.name, cc.color, COUNT(*) as 'count' from attendees inner join characters on attendees.character_id = characters.id inner join character_classes cc on characters.character_class_id = cc.id group by characters.character_class_id order by cc.name"

  has_many :adjustments, :as => :adjustable
  has_many :drops, :dependent => :destroy

  has_many :attempts  
  has_many :bosses, :through => :attempts

  has_many :kills, :group => :boss_id, :dependent => :destroy
  has_many :bosses, :through => :attempts, :source => :boss, :conditions => { :attempts => { :successful => true } }, :class_name => 'Boss'
  has_many :reserves, :through => :attempts, :group => "participants.character_id"
  
  # Methods
  def add_attendee!(character)
    attendees.create :character => character
  end
  
  def attended_by?(character)
    characters.include? character
  end

  def earnable
    kills.size * 5
  end
  
  def earned_dkp
    attendees.inject(0) { |sum, attendee| sum += attendee.earned }
  end
  
  def spent_dkp
    drops.sum(:price)
  end  
end
