class AttendeesController < ApplicationController
  respond_to :html, :xml
  
  def index
    raid = Raid.find(params[:raid_id]) if params[:raid_id]
    @character_class_sums = raid.character_classes
    respond_with(@character_class_sums)
  end

  def show
    raid = Raid.find(params[:raid_id])
    @attendee = raid.attendees.find(params[:id])
  end

  def new
  end
  
  def create
  end
  
  def destroy
    
  end

end
