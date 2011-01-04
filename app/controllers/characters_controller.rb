class CharactersController < ApplicationController
  def index
    @character_classes = CharacterClass.all
    @characters = Character.order("name ASC")
  end
  
  def show
    @character = Character.where(:id => params[:id]).first
    @attendances = @character.attendances if @character
  end

  def new
    @character = Character.new
  end
end
