class Raid < ActiveRecord::Base
  # Validations
  validates_presence_of :name

  # Assocations
  belongs_to :account
  has_many :attendees, :include => :character, :order => "characters.name", :dependent => :destroy
  has_many :characters, :through => :attendees, :order => "characters.name" do
    def inverse
      characters = Character.all
      characters.reject! { |c| self.include?(c) }
    end
  end
  
  has_many :adjustments, :as => :adjustable
  has_many :drops, :dependent => :destroy

  has_many :attempts  
  # has_many :kills, :group => :boss_id, :dependent => :destroy
  has_many :kills, :through => :attempts, :source => :boss, :conditions => { :attempts => { :successful => true } }
  has_many :bosses_killed, :through => :kills, :class_name => 'Boss', :source => :boss, :uniq => true, :order => "killed_at"
  has_many :bosses, :through => :attempts
  has_many :reserves, :through => :attempts, :group => "participants.character_id"
  
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
