class CharactersController < ApplicationController
  def index
    @character_classes = CharacterClass.all
    @characters = Character.order("name ASC")
  end

end
