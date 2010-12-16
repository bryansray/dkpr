class CharactersController < ApplicationController
  def index
    @character_classes = []
    @characters = Character.order("name ASC")
  end

end
