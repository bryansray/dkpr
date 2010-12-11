class Participant < ActiveRecord::Base
  belongs_to :attempt
  belongs_to :character
end
