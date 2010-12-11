class Boss < ActiveRecord::Base
  has_many :kills, :include => [{ :attendee => :character }], :order => "characters.name" do
    def unique
      all :group => "kills.raid_id"
    end
  end
  
  has_many :killed_by, :through => :kills, :source => :attendee, :uniq => true
  has_many :raids, :through => :kills, :source => :raid, :uniq => true
  
end
