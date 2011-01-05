class RaidsController < ApplicationController
  def index
    @raids = Raid.all
  end
  
  def show
    @raid = Raid.find(params[:id])
    @attendees = @raid.attendees
    @inverse_attendees = @raid.characters_that_did_not_attend
  end
end
