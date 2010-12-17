class CharacterClass < ActiveRecord::Base
  # Validations
  validates_presence_of :name
  
  # Associations
  has_many :characters, :order => "characters.name"

end
