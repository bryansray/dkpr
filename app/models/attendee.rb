class Attendee < ActiveRecord::Base
  before_create :set_attendee_to_be_on_time, :set_points

  # Associations
  belongs_to :character
  belongs_to :raid

  has_many :drops, :dependent => :destroy  
  has_many :kills, :dependent => :destroy
  has_many :bosses_killed, :through => :kills, :class_name => 'Boss', :source => :boss

  
  # Delegations
  delegate :name, :level, :character_class, :to => :character
  
  def on_time?
    joined_at.nil? || raid.started_at.nil? || joined_at <= raid.started_at
  end
  
  def left_early?
    left_at < raid.ended_at unless left_at.nil? or raid.ended_at.nil?
  end
  
  def there_the_whole_time?
    on_time? and not left_early?
  end
  
  def time_attended
    left_at - joined_at
  end
  
  def toggle_present!
    new_value = !present_for_all_kills?
    Kill.update_all "present = '#{new_value}'", "attendee_id = #{self.id}"
  end
  
  def spent
    drops.sum(:price)
  end
  
  def earned
    calculate_hours_attended_dkp + calculate_on_time_dkp + calculate_full_time_raid_dkp
  end
  
  def late?
    joined_at > raid.started_at
  end
  
  def present_for_all_kills?
    kills.wait_listed.size == 0
  end
  
  def has_attended_full_raid?
    left_at > raid.ended_at - 30.minutes
  end
  
  def hours_attended
    ((left_at - joined_at) / 60 / 60).to_i
  end
  
  def joined_at
    self[:joined_at] ? self[:joined_at] : Time.now
  end
  
  def left_at
    self[:left_at] ? self[:left_at] : Time.now
  end
  
  # private
    def calculate_hours_attended_dkp
      hours_attended * 5
    end
    
    def calculate_on_time_dkp
      late? ? 0 : 5
    end
    
    def calculate_full_time_raid_dkp
      has_attended_full_raid? ? 5 : 0
      
    end
    
    def add_kills_for_attendee
      raid.kills.each { |k| Kill.create :attendee => self, :boss => k.boss, :raid => raid } if raid
    end

  private
    def set_attendee_to_be_on_time
      joined_at ||= raid.started_at
    end

    def set_points
      self.on_time_points = raid.account.default_on_time_points if on_time?
      self.full_time_points = raid.account.default_full_time_points if there_the_whole_time?
    end  
end
