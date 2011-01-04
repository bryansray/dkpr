class RaidsController < ApplicationController
  def index
    @raids = Raid.all
  end
  
  def show
    @raid = Raid.find(params[:id])
    @attendees = @raid.attendees
    @inverse_attendees = []
  end
end
