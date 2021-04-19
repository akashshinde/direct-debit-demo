class EventsController < ApplicationController

  def list
    @events = Event.all.records
  end
end
