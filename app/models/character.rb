class Character < ActiveRecord::Base
  # Plugins
  acts_as_taggable_on :tags
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :level, :less_than_or_equal_to => 80, :greater_than_or_equal_to => 1

  # Associations
  belongs_to :owner, :class_name => "User"
  belongs_to :character_class
  belongs_to :account

  has_many :attendances, :class_name => 'Attendee', :dependent => :destroy
  has_many :kills, :through => :attendances
  has_many :raids, :through => :attendances
  has_many :drops, :through => :attendances
  
  has_many :adjustments, :as => :adjustee

  has_many :participations, :class_name => "Participant"
  has_many :attempts, :through => :participations
  has_many :wait_listed, :through => :participations, :source => :attempt, :conditions => { :participants => {:present => false} }

  def lifetime_points
    attendances.inject(0) { |sum, attendee| attendee.on_time? ? sum + 5 : sum }
  end

  def lifetime_attendance_percentage
    raids.size > 0 ? (raids.size.to_f / Raid.count.to_f) * 100 : 0
  end

  def current_dkp
    # attendance_dkp = calculate_raid_attendance_dkp
    adjustment_value = calculate_adjustment_dkp
    attendance_value = attendances.inject(0){ |sum, attendance| sum += attendance.earned }
    adjustment_value + attendance_value
  end
  
  def on_time_dkp
    attendances.inject(0) { |sum, attendance| sum += attendance.late? ? 0 : 5 }
  end
  
  def hours_attended_dkp
    attendances.inject(0) { |sum, attendance| sum += attendance.hours_attended * 5 }
  end
  
  def spent
    drops.sum(:price)
  end
  
  # Note - Not sure about this calculation
  def boss_kill_dkp
    kills.size * 5
  end
  
  def calculate_adjustment_dkp
    adjustments.sum(:amount)
  end

  def calculate_dkp_for(raid)
    return 0 unless raids.include?(raid)
  end
  
  def calculate_ontime_attendance
    dkp = 0
    attendances.each do |attendance|
      dkp += 5 if attendance.joined_at <= attendance.raid.started_at
    end
    dkp
  end
end
